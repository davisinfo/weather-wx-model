class Accuweather
	def get_weather_data(city,date=Date.today)
		weather_data = []
		require 'mechanize'
		m = Mechanize.new
		city.zipcode ||= '00000'
    city.zipcode = '00000' if city.zipcode.strip.empty?
		page = m.get("http://www.accuweather.com/en/us/#{city.name.downcase.gsub(" ","-")}/#{city.zipcode}/#{date.strftime("%B").downcase}-weather/#{city.code}?monyr=#{date.strftime("%m/%d/%Y")}&view=table")
		data = page.search("table.stats")[0].search("tr")
		1.upto(data.length-1) do |i|
			is_forecast = true
			if data[i]["class"] == "pre" then
				is_forecast = false
			end
			cells = data[i].search("td")
			if !cells[1].content.strip.blank? then
				_data = {}
				_data[:date] = Date.strptime(data[i].search("th")[0].content.gsub(/[a-zA-Z]+/,''),"%m/%d/%Y")
				_data[:high] = cells[0].content.strip.to_i
				_data[:low] = cells[1].content.strip.to_i
				_data[:is_forecast] = is_forecast
				weather_data << _data
			end
		end
		page = m.get("http://www.accuweather.com/en/us/#{city.name.downcase.gsub(" ","-")}/#{city.zipcode}/#{date.strftime("%B").downcase}-weather/#{city.code}?monyr=#{(date + 1.month).strftime("%m/%d/%Y")}&view=table")
		data = page.search("table.stats")[0].search("tr")
		1.upto(data.length-1) do |i|
			is_forecast = true
			if data[i]["class"] == "pre" then
				is_forecast = false
			end
			cells = data[i].search("td")
			if !cells[1].content.strip.blank? then
				_data = {}
				_data[:date] = Date.strptime(data[i].search("th")[0].content.gsub(/[a-zA-Z]+/,''),"%m/%d/%Y")
				_data[:high] = cells[0].content.strip.to_i
				_data[:low] = cells[1].content.strip.to_i
				_data[:is_forecast] = is_forecast
				weather_data << _data
			end
		end
		
		weather_data		
	end
end