class Race < ActiveRecord::Base
  attr_accessible :car_id, :date, :laps, :name, :practice_start, :race_start, :season_id, :time, :track_id
end
