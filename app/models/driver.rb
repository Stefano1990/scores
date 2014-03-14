class Driver < ActiveRecord::Base
  belongs_to    :league
  attr_accessible :beh_lead, :beh_next, :bns_pts, :laps, :name, :pos, :starts, :team, :top10, :top5, :tot_pts, :wins, :league
end
