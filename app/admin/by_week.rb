#encoding: utf-8
ActiveAdmin.register_page "By week" do
	menu :parent=>"Reports"

	content do
		total_wdata = {}
		City.all.each do |city|
			dbdata = WeatherData.where(:city_id => city).order("week,date,updated_at")

			wdata = {}
			dbdata.each do |_data|
				total_wdata[_data.week] ||= {}
				total_wdata[_data.week][_data.date] ||= {}
				total_wdata[_data.week][_data.date][:forecasts] ||= []
				total_wdata[_data.week][_data.date][:real] ||= {}
				total_wdata[_data.week][_data.date][:total] ||= {}
				total_wdata[_data.week][_data.date][:avg] ||= {}

				total_wdata[_data.week][_data.date][:total][:tdd] ||= 0
				total_wdata[_data.week][_data.date][:total][:cdd] ||= 0
				total_wdata[_data.week][_data.date][:total][:hdd] ||= 0
				total_wdata[_data.week][_data.date][:count] ||= 0
				total_wdata[_data.week][_data.date][:avg][:tdd] ||= 0
				total_wdata[_data.week][_data.date][:avg][:cdd] ||= 0
				total_wdata[_data.week][_data.date][:avg][:hdd] ||= 0

				wdata[_data.week] ||= {}
				wdata[_data.week][_data.date] ||= {}
				wdata[_data.week][_data.date][:forecasts] ||= []
				wdata[_data.week][_data.date][:real] ||= {}
				wdata[_data.week][_data.date][:total] ||= {}
				wdata[_data.week][_data.date][:avg] ||= {}
				wdata[_data.week][_data.date][:count] ||= 0
				if _data.is_forecast then
					wdata[_data.week][_data.date][:forecasts] << {:tdd => _data.tdd, :hdd => _data.hdd, :cdd => _data.cdd}
					_idx = wdata[_data.week][_data.date][:forecasts].size - 1

					total_wdata[_data.week][_data.date][:forecasts][_idx] ||= {}
					total_wdata[_data.week][_data.date][:forecasts][_idx][:tdd] ||= 0
					total_wdata[_data.week][_data.date][:forecasts][_idx][:cdd] ||= 0
					total_wdata[_data.week][_data.date][:forecasts][_idx][:hdd] ||= 0
					total_wdata[_data.week][_data.date][:forecasts][_idx][:count] ||= 0
					total_wdata[_data.week][_data.date][:forecasts][_idx][:total_tdd] ||= 0
					total_wdata[_data.week][_data.date][:forecasts][_idx][:total_cdd] ||= 0
					total_wdata[_data.week][_data.date][:forecasts][_idx][:total_hdd] ||= 0
					total_wdata[_data.week][_data.date][:forecasts][_idx][:tdd] += _data.tdd*city.population
					total_wdata[_data.week][_data.date][:forecasts][_idx][:cdd] += _data.cdd*city.population
					total_wdata[_data.week][_data.date][:forecasts][_idx][:hdd] += _data.hdd*city.population
					total_wdata[_data.week][_data.date][:forecasts][_idx][:count] += city.population
					total_wdata[_data.week][_data.date][:forecasts][_idx][:total_tdd] += _data.tdd*city.population
					total_wdata[_data.week][_data.date][:forecasts][_idx][:total_cdd] += _data.cdd*city.population
					total_wdata[_data.week][_data.date][:forecasts][_idx][:total_hdd] += _data.hdd*city.population
				else
					wdata[_data.week][_data.date][:real] = {:tdd => _data.tdd, :hdd => _data.hdd, :cdd => _data.cdd}

					total_wdata[_data.week][_data.date][:real][:tdd] ||= 0
					total_wdata[_data.week][_data.date][:real][:cdd] ||= 0
					total_wdata[_data.week][_data.date][:real][:hdd] ||= 0
					total_wdata[_data.week][_data.date][:real][:count] ||= 0
					total_wdata[_data.week][_data.date][:real][:total_tdd] ||= 0
					total_wdata[_data.week][_data.date][:real][:total_cdd] ||= 0
					total_wdata[_data.week][_data.date][:real][:total_hdd] ||= 0
					total_wdata[_data.week][_data.date][:real][:tdd] += _data.tdd*city.population
					total_wdata[_data.week][_data.date][:real][:cdd] += _data.cdd*city.population
					total_wdata[_data.week][_data.date][:real][:hdd] += _data.hdd*city.population

					total_wdata[_data.week][_data.date][:real][:count] += city.population
					total_wdata[_data.week][_data.date][:real][:total_tdd] += _data.tdd*city.population
					total_wdata[_data.week][_data.date][:real][:total_cdd] += _data.cdd*city.population
					total_wdata[_data.week][_data.date][:real][:total_hdd] += _data.hdd*city.population
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

				# global average method 2
				# total_wdata[_data.week][_data.date][:total][:tdd] = 0
				# total_wdata[_data.week][_data.date][:total][:cdd] = 0
				# total_wdata[_data.week][_data.date][:total][:hdd] = 0
				# 0.upto(4) do |_i|
					# if total_wdata[_data.week][_data.date][:forecasts][_i][:count]>0 then
						# total_wdata[_data.week][_data.date][:total][:tdd] += total_wdata[_data.week][_data.date][:forecasts][_i][:total_tdd]/total_wdata[_data.week][_data.date][:forecasts][_i][:count]
						# total_wdata[_data.week][_data.date][:total][:cdd] += total_wdata[_data.week][_data.date][:forecasts][_i][:total_tdd]/total_wdata[_data.week][_data.date][:forecasts][_i][:count]
						# total_wdata[_data.week][_data.date][:total][:hdd] += total_wdata[_data.week][_data.date][:forecasts][_i][:total_tdd]/total_wdata[_data.week][_data.date][:forecasts][_i][:count]
					# end
				# end
				# if !total_wdata[_data.week][_data.date][:real].empty? then
					# total_wdata[_data.week][_data.date][:total][:tdd] += total_wdata[_data.week][_data.date][:real][:total_tdd]/total_wdata[_data.week][_data.date][:real][:count]
					# total_wdata[_data.week][_data.date][:total][:cdd] += total_wdata[_data.week][_data.date][:real][:total_tdd]/total_wdata[_data.week][_data.date][:real][:count]
					# total_wdata[_data.week][_data.date][:total][:hdd] += total_wdata[_data.week][_data.date][:real][:total_tdd]/total_wdata[_data.week][_data.date][:real][:count]
				# end

				# global average method 1
				total_wdata[_data.week][_data.date][:total][:tdd] += _data.tdd
				total_wdata[_data.week][_data.date][:total][:cdd] += _data.cdd
				total_wdata[_data.week][_data.date][:total][:hdd] += _data.hdd
				total_wdata[_data.week][_data.date][:count] += 1

				# global average method 2
				# total_wdata[_data.week][_data.date][:count] = total_wdata[_data.week][_data.date][:forecasts].size
				# total_wdata[_data.week][_data.date][:count] += 1 unless total_wdata[_data.week][_data.date][:real].empty?

				total_wdata[_data.week][_data.date][:avg][:tdd] = total_wdata[_data.week][_data.date][:total][:tdd]*1.00/wdata[_data.week][_data.date][:count]
				total_wdata[_data.week][_data.date][:avg][:cdd] = total_wdata[_data.week][_data.date][:total][:cdd]*1.00/wdata[_data.week][_data.date][:count]
				total_wdata[_data.week][_data.date][:avg][:hdd] = total_wdata[_data.week][_data.date][:total][:hdd]*1.00/wdata[_data.week][_data.date][:count]
			end
			# panel city.name do
				# table :border => 0, :class=>"index_table index" do
					# tr :bgcolor => "white" do
						# th :rowspan=>2 do
							# "Week"
						# end
						# th :rowspan=>2 do
							# "Date"
						# end
						# th :colspan => 3 do
							# "Forecast 1"
						# end
						# th :colspan => 3 do
							# "Forecast 2"
						# end
						# th :colspan => 3 do
							# "Forecast 3"
						# end
						# th :colspan => 3 do
							# "Forecast 4"
						# end
						# th :colspan => 3 do
							# "Forecast 5"
						# end
						# th :colspan => 3 do
							# "Real"
						# end
						# # th :colspan => 3 do
							# # "Average"
						# # end
					# end
					# tr do
						# th "TDD"
						# th "CDD"
						# th "HDD"
						# th "TDD"
						# th "CDD"
						# th "HDD"
						# th "TDD"
						# th "CDD"
						# th "HDD"
						# th "TDD"
						# th "CDD"
						# th "HDD"
						# th "TDD"
						# th "CDD"
						# th "HDD"
						# th "TDD"
						# th "CDD"
						# th "HDD"
						# # th "TDD"
						# # th "CDD"
						# # th "HDD"
					# end
					# wdata.each do |_week,_data|
						# first = true
						# _total_tdd = []
						# _total_cdd = []
						# _total_hdd = []
						# _count = []
						# 0.upto(6) do |_i|
							# _total_tdd[_i] = 0
							# _total_cdd[_i] = 0
							# _total_hdd[_i] = 0
							# _count[_i] = 0
						# end
						# _data.each do |_day,_day_data|
							# tr do
								# if first then
									# td :rowspan => _data.size do
										# _week
									# end
								# first = false
								# end
								# _day_data[:forecasts][0] ||= {}
								# _day_data[:forecasts][1] ||= {}
								# _day_data[:forecasts][2] ||= {}
								# _day_data[:forecasts][3] ||= {}
								# _day_data[:forecasts][4] ||= {}
								# 0.upto(4) do |_i|
									# if !_day_data[:forecasts][_i][:tdd].nil? then
										# _total_tdd[_i] += _day_data[:forecasts][_i][:tdd]
										# _total_cdd[_i] += _day_data[:forecasts][_i][:cdd]
										# _total_hdd[_i] += _day_data[:forecasts][_i][:hdd]
										# _count[_i] += 1
									# end
								# end
								# _total_tdd[5] += _day_data[:real][:tdd].to_f
								# _total_cdd[5] += _day_data[:real][:cdd].to_f
								# _total_hdd[5] += _day_data[:real][:hdd].to_f
								# _count[5] += 1
								# _total_tdd[6] += _day_data[:total][:tdd].to_f
								# _total_cdd[6] += _day_data[:total][:cdd].to_f
								# _total_hdd[6] += _day_data[:total][:hdd].to_f
								# _count[6] += 1
								# td _day
								# td _day_data[:forecasts][0][:tdd]
								# td _day_data[:forecasts][0][:cdd]
								# td _day_data[:forecasts][0][:hdd]
								# td _day_data[:forecasts][1][:tdd]
								# td _day_data[:forecasts][1][:cdd]
								# td _day_data[:forecasts][1][:hdd]
								# td _day_data[:forecasts][2][:tdd]
								# td _day_data[:forecasts][2][:cdd]
								# td _day_data[:forecasts][2][:hdd]
								# td _day_data[:forecasts][3][:tdd]
								# td _day_data[:forecasts][3][:cdd]
								# td _day_data[:forecasts][3][:hdd]
								# td _day_data[:forecasts][4][:tdd]
								# td _day_data[:forecasts][4][:cdd]
								# td _day_data[:forecasts][4][:hdd]
								# td _day_data[:real][:tdd]
								# td _day_data[:real][:cdd]
								# td _day_data[:real][:hdd]
								# # td _day_data[:avg][:tdd]
								# # td _day_data[:avg][:cdd]
								# # td _day_data[:avg][:hdd]
							# end
						# end
						# # tr do
							# # td "Average"
							# # 0.upto(6) do |_i|
								# # td _count[_i]==0? "-" : number_with_precision(_total_tdd[_i] / _count[_i], :precision => 2)
								# # td _count[_i]==0? "-" : number_with_precision(_total_cdd[_i] / _count[_i], :precision => 2)
								# # td _count[_i]==0? "-" : number_with_precision(_total_hdd[_i] / _count[_i], :precision => 2)
							# # end
						# # end
					# end
				# end
			# end
		end
		# panel "Grand Total" do
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
						"TOTAL"
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
				total_wdata.each do |_week,_data|
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
					_total_tdd[6] = 0
					_total_cdd[6] = 0
					_total_hdd[6] = 0
					_data.each do |_day,_day_data|
            _last_tdd = 0
            _last_cdd = 0
            _last_hdd = 0
						tr do
							_day_data[:total][:tdd] = 0
							_day_data[:total][:cdd] = 0
							_day_data[:total][:hdd] = 0
							if first then
								td :rowspan => _data.size+1, :style=> "vertical-align:middle" do
									h4 b _week
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
									_total_tdd[_i] += _day_data[:forecasts][_i][:tdd]/_day_data[:forecasts][_i][:count]
									_total_cdd[_i] += _day_data[:forecasts][_i][:cdd]/_day_data[:forecasts][_i][:count]
									_total_hdd[_i] += _day_data[:forecasts][_i][:hdd]/_day_data[:forecasts][_i][:count]
									#_total_tdd[6] += _day_data[:forecasts][_i][:tdd]/_day_data[:forecasts][_i][:count]
									#_total_cdd[6] += _day_data[:forecasts][_i][:cdd]/_day_data[:forecasts][_i][:count]
									#_total_hdd[6] += _day_data[:forecasts][_i][:hdd]/_day_data[:forecasts][_i][:count]
									_day_data[:total][:tdd] += _day_data[:forecasts][_i][:tdd]/_day_data[:forecasts][_i][:count]
									_day_data[:total][:cdd] += _day_data[:forecasts][_i][:tdd]/_day_data[:forecasts][_i][:count]
									_day_data[:total][:hdd] += _day_data[:forecasts][_i][:tdd]/_day_data[:forecasts][_i][:count]
									_count[_i] += 1
								end
							end
							_total_tdd[5] += _day_data[:real][:tdd]/_day_data[:real][:count] if _day_data[:real][:tdd]
							_total_cdd[5] += _day_data[:real][:cdd]/_day_data[:real][:count] if _day_data[:real][:cdd]
							_total_hdd[5] += _day_data[:real][:hdd]/_day_data[:real][:count] if _day_data[:real][:hdd]
							#_total_tdd[6] += _day_data[:real][:tdd]/_day_data[:real][:count] if _day_data[:real][:tdd]
							#_total_cdd[6] += _day_data[:real][:cdd]/_day_data[:real][:count] if _day_data[:real][:cdd]
							#_total_hdd[6] += _day_data[:real][:hdd]/_day_data[:real][:count] if _day_data[:real][:hdd]
							_day_data[:total][:tdd] += _day_data[:real][:tdd]/_day_data[:real][:count] if _day_data[:real][:tdd]
							_day_data[:total][:cdd] += _day_data[:real][:cdd]/_day_data[:real][:count] if _day_data[:real][:cdd]
							_day_data[:total][:hdd] += _day_data[:real][:hdd]/_day_data[:real][:count] if _day_data[:real][:hdd]
							_count[5] += 1
							_count[6] += 1
							td _day
              _last = nil
							0.upto(4) do |_i|
								td _day_data[:forecasts][_i][:tdd].nil? ? "-" : number_with_precision(_day_data[:forecasts][_i][:tdd]/_day_data[:forecasts][_i][:count], :precision => 2)
								td _day_data[:forecasts][_i][:tdd].nil? ? "-" : number_with_precision(_day_data[:forecasts][_i][:cdd]/_day_data[:forecasts][_i][:count], :precision => 2)
								td _day_data[:forecasts][_i][:tdd].nil? ? "-" : number_with_precision(_day_data[:forecasts][_i][:hdd]/_day_data[:forecasts][_i][:count], :precision => 2)

                if !_day_data[:forecasts][_i][:tdd].nil? then
                  _last_tdd = _day_data[:forecasts][_i][:tdd]/_day_data[:forecasts][_i][:count]
                  _last_cdd = _day_data[:forecasts][_i][:cdd]/_day_data[:forecasts][_i][:count]
                  _last_hdd = _day_data[:forecasts][_i][:hdd]/_day_data[:forecasts][_i][:count]
                end
							end
							td _day_data[:real][:tdd].nil? ? "-" : number_with_precision(_day_data[:real][:tdd]/_day_data[:real][:count], :precision => 2)
							td _day_data[:real][:tdd].nil? ? "-" : number_with_precision(_day_data[:real][:cdd]/_day_data[:real][:count], :precision => 2)
							td _day_data[:real][:tdd].nil? ? "-" : number_with_precision(_day_data[:real][:hdd]/_day_data[:real][:count], :precision => 2)
              if !_day_data[:real][:tdd].nil? then
                _last_tdd = _day_data[:real][:tdd]/_day_data[:real][:count]
                _last_cdd = _day_data[:real][:cdd]/_day_data[:real][:count]
                _last_hdd = _day_data[:real][:hdd]/_day_data[:real][:count]
              end
              _total_tdd[6] += _last_tdd if _last_tdd
              _total_cdd[6] += _last_cdd if _last_cdd
              _total_hdd[6] += _last_hdd if _last_hdd
							td :style=> "background-color:#EEEEEE" do
								number_with_precision(_last_tdd, :precision => 2)
							end
							td :style=> "background-color:#EEEEEE" do
								number_with_precision(_last_cdd, :precision => 2)
							end
							td :style=> "background-color:#EEEEEE" do
								number_with_precision(_last_hdd, :precision => 2)
							end
						end
					end
					tr :style=> "background-color:#EEEEEE" do
						td b "TOTAL"
						0.upto(5) do |_i|
							td _count[_i]==0? "-" : number_with_precision(_total_tdd[_i], :precision => 2)
							td _count[_i]==0? "-" : number_with_precision(_total_cdd[_i], :precision => 2)
							td _count[_i]==0? "-" : number_with_precision(_total_hdd[_i], :precision => 2)
						end
						td :style=> "background-color:#CCCCCC" do
							b number_with_precision(_total_tdd[6], :precision => 2)
						end
						td :style=> "background-color:#CCCCCC" do
							b number_with_precision(_total_cdd[6], :precision => 2)
						end
						td :style=> "background-color:#CCCCCC" do
							b number_with_precision(_total_hdd[6], :precision => 2)
						end
					end
				end
			end
		# end
	end
end
