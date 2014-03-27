class Result < ActiveRecord::Base
  include ImageComposer

  belongs_to  :league
  dragonfly_accessor  :image
  attr_accessible     :url, :league_id, :image_name, :image_uid, :first_entry, :last_entry
  validate            :url, :check_url
  validates            :first_entry, :last_entry, inclusion: 1..120

  after_create        :make_image

  def check_url
    if !(url =~ /season_standings/).nil?
      errors.add(:url, "please check your url. This URL looks like a standings URL.")
    end
  end


end
