#encoding: utf-8
ActiveAdmin.register_page "CscsRegistrationBreakdown" do
  menu :parent=>"Reports"

  content do
    data = WeatherData.order("week,computed_on")
  end
end
