class City < ActiveRecord::Base
  attr_accessible :code, :name, :zipcode, :population, :region
end
