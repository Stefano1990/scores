class DriverTeamConnection < ActiveRecord::Base
  attr_accessible :driver_id, :team_id
  belongs_to      :driver
  belongs_to      :team
end
