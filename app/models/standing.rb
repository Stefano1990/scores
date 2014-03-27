class Standing < ActiveRecord::Base
  include ImageComposer
  belongs_to    :league

  #has_one     :standing_config
  #dragonfly_accessor :background
  #dragonfly_accessor :composite
  dragonfly_accessor :image
  #attr_accessible :background_name, :background_uid, :league_id, :background, :standing_config
  attr_accessible   :league_id, :image_name, :image_uid, :url
  validate          :url, :check_url

  after_create      :make_image

  def check_url
    if !(url =~ /season_race/).nil?
      errors.add(:url, "please check your url. This URL looks like a results URL.")
    end
  end


end
