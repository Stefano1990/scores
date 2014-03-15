class LeagueConfig < ActiveRecord::Base
  belongs_to          :league
  dragonfly_accessor  :config
  attr_accessible     :config_name, :config_uid, :league_id
end
