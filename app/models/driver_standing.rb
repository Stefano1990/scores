class DriverStanding < ActiveRecord::Base
  attr_accessible :bns_pts, :driver_id, :inc, :laps_comp, :laps_led, :race_pts, :standing_id, :team_id, :tot_pts
  belongs_to        :standing, class_name: 'Standing', foreign_key: 'standing_id'
  belongs_to        :driver, class_name: 'Driver', foreign_key: 'driver_id'
end
