class PointSystem < ActiveRecord::Base
  attr_protected
  belongs_to      :season

  delegate        :series, to: :season
  delegate        :league, to: :series

  after_save      :expire_results_and_standings

  def expire_results_and_standings
    season.results.each { |result| result.recalculate }
    season.driver_standings.each { |driver_standing| driver_standing.recalculate }
  end

  def pts_for(nr)
    send("pts_#{nr}")
  end
end
