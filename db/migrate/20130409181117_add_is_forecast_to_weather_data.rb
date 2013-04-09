class AddIsForecastToWeatherData < ActiveRecord::Migration
  def up
  	add_column :weather_data, :is_forecast, :boolean
  end
  def down
  	remove_column :weather_data, :is_forecast
  end
end
