class DriverStandingGraphic < ActiveRecord::Base
  include ImageComposer

  belongs_to :standing
  dragonfly_accessor    :image

  attr_accessible :image_name, :image_uid, :standing_id, :url, :first_pos, :last_pos

  delegate :season, to: :standing
  delegate :series, to: :standing
  delegate :driver_standings, to: :standing

  def create_image(i,nr_of_graphics)
    @config = JSON.parse(season.config)
    @entries = @config['general']['entries']
    limit = @entries
    offset = @entries*i
    @background = season.background
    @canvas = MiniMagick::Image.open(@background.path)
    @driver_standings = driver_standings.limit(limit).offset(offset)
    @font_attributes = font_attributes_hash # defined in ImageComposer
    compose_sub_image('pos','positions') if @config["general"]['positions']
    compose_sub_image('name','names') if @config["general"]['names']
    compose_sub_image('team','teams') if @config["general"]['teams']
    compose_sub_image('tot_pts','scores') if @config["general"]['scores']

    @canvas.write("#{@background.path.sub(/.png/, '')}-generated.png") # overwrite the old attachment. remove the last .png
    self.image = Pathname.new("#{@background.path.sub(/.png/, '')}-generated.png")
    filename = "#{series.name.parameterize}-#{season.name.parameterize}-driver-standings-race-2-of-10-#{i+1}-of-#{nr_of_graphics}"
    image.to_file("#{Rails.root}/public/system/dragonfly/#{Rails.env}/#{filename}.png")
    self.url = "/system/dragonfly/#{Rails.env}/#{filename}.png?timestamp=#{self.updated_at.to_i}"
    self.save
  end

  def compose_sub_image(model_attribute,config_attribute)
    string = ""
    font_attributes = combine_font_properties(config_attribute)
    case model_attribute
      when "name" then @driver_standings.each{|ds| string << "#{ds.driver.name}\n" }
      when "pos" then @driver_standings.each{|ds| string << "#{ds.pos}\n" }
      when "team" then
        @driver_standings.each do |ds|
          if ds.team then string << "#{ds.team.name}\n" else string << "\n" end
        end
      when "tot_pts" then @driver_standings.each{|ds| string << "#{ds.tot_pts}\n" }
    end
    x = @config[config_attribute]["x-pos"]
    y = @config['general']['y-pos']
    sub_image_job = Dragonfly.app.generate(:multiline,string,font_attributes)
    sub_image = MiniMagick::Image.open(sub_image_job.path)
    @canvas = @canvas.composite(sub_image) { |c| c.compose "Over"; c.geometry "+#{x}+#{y}" }
  end
end
