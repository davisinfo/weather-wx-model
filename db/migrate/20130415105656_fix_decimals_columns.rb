class FixDecimalsColumns < ActiveRecord::Migration
  def change
  	change_column :weather_data, :hdd, :decimal, :precision => 5, :scale => 2
  	change_column :weather_data, :cdd, :decimal, :precision => 5, :scale => 2
  	change_column :weather_data, :tdd, :decimal, :precision => 5, :scale => 2
  end
end
