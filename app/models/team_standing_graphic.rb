class TeamStandingGraphic < ActiveRecord::Base
  include ImageComposer

  belongs_to :standing
  dragonfly_accessor    :image

  attr_accessible :first_pos, :image_name, :image_uid, :last_pos, :standing_id, :url

  delegate :season, to: :standing
  delegate :series, to: :standing
  delegate :team_standings, to: :standing

  def create_image(i,nr_of_graphics)
    @config = JSON.parse(season.config)
    @entries = @config['general']['entries']
    limit = @entries
    offset = @entries*i
    @background = season.background
    @canvas = MiniMagick::Image.open(@background.path)
    @team_standings = team_standings.limit(limit).offset(offset)
    @font_attributes = font_attributes_hash # defined in ImageComposer
    compose_sub_image('pos','positions') if @config["general"]['positions']
    compose_sub_image('name','names') if @config["general"]['names']
    compose_sub_image('tot_pts','scores') if @config["general"]['scores']

    @canvas.write("#{@background.path.sub(/.png/, '')}-generated.png") # overwrite the old attachment. remove the last .png
    self.image = Pathname.new("#{@background.path.sub(/.png/, '')}-generated.png")
    filename = "#{series.name.parameterize}-#{season.name.parameterize}-team-standings-race-2-of-10-#{i+1}-of-#{nr_of_graphics}"
    image.to_file("#{Rails.root}/public/system/dragonfly/#{Rails.env}/#{filename}.png")
    self.url = "/system/dragonfly/#{Rails.env}/#{filename}.png?timestamp=#{self.updated_at.to_i}"
    self.save
  end

  def compose_sub_image(model_attribute,config_attribute)
    string = ""
    font_attributes = combine_font_properties(config_attribute)
    case model_attribute
      when "name" then @team_standings.each{|ts| string << "#{ts.team.name}\n" if ts.team }
      when "pos" then @team_standings.each{|ts| string << "#{ts.pos}\n" if ts.team }
      when "tot_pts" then @team_standings.each{|ts| string << "#{ts.tot_pts}\n" if ts.team }
    end
    x = @config[config_attribute]["x-pos"]
    y = @config['general']['y-pos']
    sub_image_job = Dragonfly.app.generate(:multiline,string,font_attributes)
    sub_image = MiniMagick::Image.open(sub_image_job.path)
    @canvas = @canvas.composite(sub_image) { |c| c.compose "Over"; c.geometry "+#{x}+#{y}" }
  end
end
