class AddZipCodeToCities < ActiveRecord::Migration
  def change
  	add_column :cities, :zipcode, :string
  end
end
