class PointSystem < ActiveRecord::Base
  attr_protected
  belongs_to      :season

  delegate        :series, to: :season
  delegate        :league, to: :series

  after_save      :expire_all_results

  def expire_all_results
    season.results.each do |result|
      result.recalculate
    end
  end

  def pts_for(nr)
    send("pts_#{nr}")
  end
end
