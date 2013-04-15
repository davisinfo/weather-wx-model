task :update_data => :environment do
  puts "Updating weather data..."

  require 'accuweather'
  aw = Accuweather.new

  computed_on = Date.today
  City.all.each do |city|
    puts "Updating #{city.name}"
    data = aw.get_weather_data(city)
    data.each do |_wd|
      wd = WeatherData.find_or_create_by_city_id_and_date_and_computed_on(city.id,_wd[:date], computed_on)
      wd.high = _wd[:high]
      wd.low = _wd[:low]
      wd.computed_on = computed_on
      _avg = (_wd[:high]*1.00 + _wd[:low]*1.00) / 2.00
      wd.cdd = 0
      wd.hdd = 0
      if _avg > 65 then
        wd.cdd = _avg - 65.00
      else
        wd.hdd = 65.00 - _avg
      end
      wd.tdd = wd.cdd + wd.hdd
      wd.is_forecast = _wd[:is_forecast]
      wd.save
      wd.get_week
      _wds = WeatherData.find_all_by_date_and_is_forecast(_wd[:date],true,:order => "computed_on desc")
      5.upto(_wds.count) do |i|
        _wds[i].destroy unless _wds[i].nil?
      end
    end
  end

  puts "done."
end
