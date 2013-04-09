ActiveAdmin.register WeatherData do
	index do
		column :id
		column :date
		column :city
		column :high
		column :low
		column :cdd
		column :hdd
		column :tdd
		column :is_forecast
		column :computed_on
		column :updated_at
		#default_actions
	end  
end
