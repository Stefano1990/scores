class Round < ActiveRecord::Base
  belongs_to      :schedule
  belongs_to      :track
  belongs_to      :result

  delegate        :name, to: :track

  attr_accessible :schedule_id, :start, :track_id, :track
end
