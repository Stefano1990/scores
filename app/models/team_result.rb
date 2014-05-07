class TeamResult < ActiveRecord::Base
  attr_accessible :bns_pts, :inc, :laps_comp, :laps_led, :league_points, :race_pts, :result_id, :team, :result
  belongs_to      :team
  belongs_to      :result
  has_many        :driver_results, foreign_key: 'team_id', primary_key: 'team_id'
  has_many        :drivers, through: :driver_results

  def recalculate
    [:laps_led, :laps_comp, :inc, :race_pts, :bns_pts].each do |att|
      self[att] = 0
      driver_results.each do |driver_result|
        self[att] += driver_result[att].to_i
      end
    end
    self.save
  end
end
