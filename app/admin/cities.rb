ActiveAdmin.register City do
	index do
		column :id
		column :name
		column :code
		column :zipcode
		column :population
		column :region
		column :actions do |city|
			li link_to "Update data", update_data_admin_city_path(city)
		end
		default_actions
	end

	member_action :update_data do
		require 'accuweather'
		
		city = City.find(params[:id])
		aw = Accuweather.new
		data = aw.get_weather_data(city)
	    data.each do |_wd|
	      wd = WeatherData.find_or_create_by_city_id_and_date_and_computed_on_and_is_forecast(city.id,_wd[:date], computed_on,_wd[:is_forecast])
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
		
		redirect_to admin_cities_path and return
	end
	
	action_item :only => :index do
		link_to "Update data for all", update_all_admin_cities_path
	end
	
	collection_action :update_all do
		require 'accuweather'
		aw = Accuweather.new

		computed_on = Date.today
		City.all.each do |city|		
			data = aw.get_weather_data(city)
		    data.each do |_wd|
		      wd = WeatherData.find_or_create_by_city_id_and_date_and_computed_on_and_is_forecast(city.id,_wd[:date], computed_on,_wd[:is_forecast])
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
		
		redirect_to admin_cities_path and return
	end  
end
