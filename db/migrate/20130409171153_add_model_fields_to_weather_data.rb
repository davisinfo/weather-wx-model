class AddModelFieldsToWeatherData < ActiveRecord::Migration
  def up
  	add_column :weather_data, :computed_on, :date
  	add_column :weather_data, :hdd, :decimal, :precision => 5, :scale => 2
  	add_column :weather_data, :cdd, :decimal, :precision => 5, :scale => 2
  	add_column :weather_data, :tdd, :decimal, :precision => 5, :scale => 2
  	add_column :weather_data, :week, :string
  end

  def down
  	remove_column :weather_data, :computed_on
  	remove_column :weather_data, :hdd
  	remove_column :weather_data, :cdd
  	remove_column :weather_data, :tdd
  	remove_column :weather_data, :week
  end
end
