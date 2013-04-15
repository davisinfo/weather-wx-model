#encoding: utf-8
ActiveAdmin.register_page "By week" do
	menu :parent=>"Reports"

	content do
		City.all.each do |city|
			dbdata = WeatherData.where(:city_id => city).order("week,date,computed_on")

			wdata = {}
			dbdata.each do |_data|
				wdata[_data.week] ||= {}
				wdata[_data.week][_data.date] ||= {}
				wdata[_data.week][_data.date][:forecasts] ||= []
				wdata[_data.week][_data.date][:real] ||= {}
				wdata[_data.week][_data.date][:total] ||= {}
				wdata[_data.week][_data.date][:avg] ||= {}
				wdata[_data.week][_data.date][:count] ||= 0
				if _data.is_forecast then
					wdata[_data.week][_data.date][:forecasts] << {:tdd => _data.tdd, :hdd => _data.hdd, :cdd => _data.cdd}
				else
					wdata[_data.week][_data.date][:real] = {:tdd => _data.tdd, :hdd => _data.hdd, :cdd => _data.cdd}
				end
				wdata[_data.week][_data.date][:total][:tdd] ||= 0
				wdata[_data.week][_data.date][:total][:cdd] ||= 0
				wdata[_data.week][_data.date][:total][:hdd] ||= 0
				wdata[_data.week][_data.date][:avg][:tdd] ||= 0
				wdata[_data.week][_data.date][:avg][:cdd] ||= 0
				wdata[_data.week][_data.date][:avg][:hdd] ||= 0
				wdata[_data.week][_data.date][:total][:tdd] += _data.tdd
				wdata[_data.week][_data.date][:total][:cdd] += _data.cdd
				wdata[_data.week][_data.date][:total][:hdd] += _data.hdd
				wdata[_data.week][_data.date][:count] += 1
				wdata[_data.week][_data.date][:avg][:tdd] = wdata[_data.week][_data.date][:total][:tdd]*1.00/wdata[_data.week][_data.date][:count]
				wdata[_data.week][_data.date][:avg][:cdd] = wdata[_data.week][_data.date][:total][:cdd]*1.00/wdata[_data.week][_data.date][:count]
				wdata[_data.week][_data.date][:avg][:hdd] = wdata[_data.week][_data.date][:total][:hdd]*1.00/wdata[_data.week][_data.date][:count]
			end
			panel city.name do
				table :border => 0, :class=>"index_table index" do
					tr :bgcolor => "white" do
						th :rowspan=>2 do
							"Week"
						end
						th :rowspan=>2 do
							"Date"
						end
						th :colspan => 3 do
							"Forecast 1"
						end
						th :colspan => 3 do
							"Forecast 2"
						end
						th :colspan => 3 do
							"Forecast 3"
						end
						th :colspan => 3 do
							"Forecast 4"
						end
						th :colspan => 3 do
							"Forecast 5"
						end
						th :colspan => 3 do
							"Real"
						end
						th :colspan => 3 do
							"Average"
						end
					end
					tr do
						th "TDD"
						th "CDD"
						th "HDD"
						th "TDD"
						th "CDD"
						th "HDD"
						th "TDD"
						th "CDD"
						th "HDD"
						th "TDD"
						th "CDD"
						th "HDD"
						th "TDD"
						th "CDD"
						th "HDD"
						th "TDD"
						th "CDD"
						th "HDD"
						th "TDD"
						th "CDD"
						th "HDD"
					end
					wdata.each do |_week,_data|
						first = true
						_total_tdd = []
						_total_cdd = []
						_total_hdd = []
						_count = []
						0.upto(6) do |_i|
							_total_tdd[_i] = 0
							_total_cdd[_i] = 0
							_total_hdd[_i] = 0
							_count[_i] = 0
						end
						_data.each do |_day,_day_data|
							tr do
								if first then
									td :rowspan => _data.size+1 do
										_week
									end
								first = false
								end
								_day_data[:forecasts][0] ||= {}
								_day_data[:forecasts][1] ||= {}
								_day_data[:forecasts][2] ||= {}
								_day_data[:forecasts][3] ||= {}
								_day_data[:forecasts][4] ||= {}
								0.upto(4) do |_i|
									if !_day_data[:forecasts][_i][:tdd].nil? then
										_total_tdd[_i] += _day_data[:forecasts][_i][:tdd]
										_total_cdd[_i] += _day_data[:forecasts][_i][:cdd]
										_total_hdd[_i] += _day_data[:forecasts][_i][:hdd]
										_count[_i] += 1
									end
								end
								_total_tdd[5] += _day_data[:real][:tdd].to_f
								_total_cdd[5] += _day_data[:real][:cdd].to_f
								_total_hdd[5] += _day_data[:real][:hdd].to_f
								_count[5] += 1
								_total_tdd[6] += _day_data[:total][:tdd].to_f
								_total_cdd[6] += _day_data[:total][:cdd].to_f
								_total_hdd[6] += _day_data[:total][:hdd].to_f
								_count[6] += 1
								td _day
								td _day_data[:forecasts][0][:tdd]
								td _day_data[:forecasts][0][:cdd]
								td _day_data[:forecasts][0][:hdd]
								td _day_data[:forecasts][1][:tdd]
								td _day_data[:forecasts][1][:cdd]
								td _day_data[:forecasts][1][:hdd]
								td _day_data[:forecasts][2][:tdd]
								td _day_data[:forecasts][2][:cdd]
								td _day_data[:forecasts][2][:hdd]
								td _day_data[:forecasts][3][:tdd]
								td _day_data[:forecasts][3][:cdd]
								td _day_data[:forecasts][3][:hdd]
								td _day_data[:forecasts][4][:tdd]
								td _day_data[:forecasts][4][:cdd]
								td _day_data[:forecasts][4][:hdd]
								td _day_data[:real][:tdd]
								td _day_data[:real][:cdd]
								td _day_data[:real][:hdd]
								td _day_data[:avg][:tdd]
								td _day_data[:avg][:cdd]
								td _day_data[:avg][:hdd]
							end
						end
						tr do
							td "Average"
							0.upto(6) do |_i|
								td _count[_i]==0? "-" : number_with_precision(_total_tdd[_i] / _count[_i], :precision => 2)
								td _count[_i]==0? "-" : number_with_precision(_total_cdd[_i] / _count[_i], :precision => 2)
								td _count[_i]==0? "-" : number_with_precision(_total_hdd[_i] / _count[_i], :precision => 2)
							end
						end
					end
				end
			end
		end
	end
end
