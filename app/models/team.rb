class Team < ActiveRecord::Base
  attr_accessible :name, :season_id, :driver_ids
  belongs_to :season
  has_many   :driver_team_connections
  has_many   :drivers, through: :driver_team_connections

  validates   :name, presence: true
end
