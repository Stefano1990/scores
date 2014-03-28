class Result < ActiveRecord::Base
  include ImageComposer

  belongs_to  :graphic
  dragonfly_accessor  :image
  attr_accessible     :url, :graphic_id, :image_name, :image_uid, :first_entry, :last_entry
  validate            :url, :check_url
  validates            :first_entry, :last_entry, inclusion: 1..120

  after_create        :make_image
  before_save         :get_meta_data

  def check_url
    if !(url =~ /season_standings/).nil?
      errors.add(:url, "Please check your url. This URL looks like a standings URL.")
    end
  end

  def get_meta_data
    get_image
    get_round
  end

  def get_name
    #
  end

  def get_round
    if round.nil? || round.empty?
      @doc ||= Nokogiri::HTML(open(url))
      self.round = @doc.css('select[name=schedule_id] option[selected]').first.text.scan(/\((.*)\)/).flatten.first
    end
  end

  def get_image
    if track_image_url.nil? || track_image_url.empty?
      @doc ||= Nokogiri::HTML(open(url))
      self.track_image_url = "http://danlisa.com/scoring/"+@doc.css('img[style="border: 1px solid #666666;"]').first[:src]
    end
  end
end
