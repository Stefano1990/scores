class Result < ActiveRecord::Base
  include ImageComposer

  belongs_to  :league
  dragonfly_accessor  :image
  attr_accessible     :url, :league_id, :image_name, :image_uid
  validate            :url, :check_url

  after_create        :make_image

  def check_url
    if !(url =~ /season_standings/).nil?
      errors.add(:url, "please check your url. This URL looks like a standings URL.")
    end
  end


end
