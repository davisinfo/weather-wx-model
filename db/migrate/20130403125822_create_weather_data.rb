class CreateWeatherData < ActiveRecord::Migration
  def change
    create_table :weather_data do |t|
      t.date :date
      t.references :city
      t.integer :high
      t.integer :low

      t.timestamps
    end
    add_index :weather_data, :city_id
  end
end
