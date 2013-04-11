class WeatherData < ActiveRecord::Base
  belongs_to :city
  attr_accessible :date, :high, :low, :city_id

  def get_week
    today = self.date.strftime('%w').to_i
    week_start = nil
    if today < 5 then
      week_start = self.date - (today + 2).days
    else
      week_start = self.date - (today - 5).days
    end
    week_end = week_start + 6.days

    self.week ||= week_start.strftime("%Y-%m-%d") + " - " + week_end.strftime("%Y-%m-%d")
    self.save

    return self.week
  end
end
