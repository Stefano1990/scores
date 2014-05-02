class TeamStanding < ActiveRecord::Base
  attr_accessible :bns_pts, :inc, :laps_comp, :laps_led, :penalty_pts, :pos, :race_pts, :standing_id, :team_id, :tot_pts

  belongs_to      :standing, class_name: 'Standing', foreign_key: 'standing_id'
  belongs_to      :team, class_name: 'Team', foreign_key: 'team_id'
end
