ActiveAdmin.register City do
	index do
		column :id
		column :name
		column :code
		column :zipcode
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
			wd = WeatherData.find_or_create_by_city_id_and_date(city.id,_wd[:date])
			wd.high = _wd[:high]
			wd.low = _wd[:low]
			wd.save
		end
		
		redirect_to admin_cities_path and return
	end  
end
