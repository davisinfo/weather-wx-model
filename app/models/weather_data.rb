class WeatherData < ActiveRecord::Base
  belongs_to :city
  attr_accessible :date, :high, :low, :city_id
end
