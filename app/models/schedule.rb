class Schedule < ActiveRecord::Base
  belongs_to      :season
  has_many        :rounds, order: 'start asc', dependent: :destroy

  delegate        :series, to: :season
  delegate        :league, to: :season

  accepts_nested_attributes_for :rounds, allow_destroy: true

  attr_accessible :season_id, :round, :rounds_attributes

  def find_round_for_result(date,track)
    # This is only done like this because FUCK SQL
    track = Track.find_by_iracing_name(track)
    date_int = Time.parse(date).to_i
    closest_round = nil
    rounds.where(track_id: track).each do |round|
      if closest_round.nil?    # for the first round.
        closest_round = round
      else
        if (closest_round.start.to_i - date_int).abs > (round.start.to_i - date_int).abs
          closest_round = round
        end
      end
    end
    closest_round
  end
end
