class DriverResult < ActiveRecord::Base
  attr_accessible :driver_id, :result_id,  :result_id, :driver_id, :fin_pos, :car_id, :car,
                  :car_class_id, :car_class, :cust_id, :name, :start_pos, :car_nr, :out_id,
                  :out, :interval, :laps_led, :average_lap_time, :fastest_lap_time, :fast_lap_nr,
                  :laps_comp, :inc, :league_points
end
