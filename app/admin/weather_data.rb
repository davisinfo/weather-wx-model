ActiveAdmin.register WeatherData do
	index do
		column :id
		column :date
		column :city
		column :high
		column :low
		column :updated_at
		#default_actions
	end  
end
