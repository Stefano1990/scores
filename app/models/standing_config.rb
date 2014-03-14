class StandingConfig < ActiveRecord::Base
  belongs_to :standing
  dragonfly_accessor :config
  attr_accessible :config_name, :config_uid, :standing_id, :config
end
