class Series < ActiveRecord::Base
  attr_accessible :description, :league_id, :name
  belongs_to      :league
  has_many        :seasons

  delegate :user, to: :league

  def to_param
    "#{id}-#{name}"
  end
end
