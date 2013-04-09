class AddPopulationAndRegionToCities < ActiveRecord::Migration
  def up
  	add_column :cities, :population, :bigint
  	add_column :cities, :region, :string
  end
  def down
  	remove_column :cities, :population, :bigint
  	remove_column :cities, :region, :string
  end
end
