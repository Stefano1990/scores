class DriverBonus < ActiveRecord::Base
  attr_accessible :driver_result_id, :fastest_lap, :lap_led, :pole, :driver, :driver_result
  belongs_to      :driver_result
end
