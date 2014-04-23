class Driver < ActiveRecord::Base
  has_many      :driver_team_connections
  has_many      :teams, through: :driver_team_connections
  validates     :customer_id, presence: true, uniqueness: true
  validates     :name, presence: true
  attr_protected


  def team_for_season(season)
    teams.where(season_id: season.id).first
  end
end
