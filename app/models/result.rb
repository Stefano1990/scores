class Result < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to  :league
  dragonfly_accessor  :composite
  attr_accessible     :league_id, :composite

  def refresh
    _composite = MiniMagick::Image.open(background.path)
    config = JSON.parse(File.read(standing_config.config.path)) # read the config
    config['drivers'].each_with_index do |driver, i|
      # find the driver in the league
      league_driver = league.drivers.find_by_pos(driver['place'])
      # generate the name
      driver_name = Dragonfly.app.generate(:text, league_driver.name,
                                           'font-size' => 120,                 # defaults to 12
                                           'font' => "#{Rails.root}/public/images/fonts/Roboto-Regular.ttf",
                                           #'font' => 'Roboto',
                                           'color' => 'yellow',
                                           'padding' => '30 20 10'
      )
      driver_name = driver_name.convert('-density 288 -resize 25%')
      driver_name_image = MiniMagick::Image.open(driver_name.path)
      _composite = _composite.composite(driver_name_image) { |c| c.compose "Over"; c.geometry "+#{driver['pos-x']}+#{driver['pos-y']}" }
      # generate the points
      points_text = Dragonfly.app.generate(:text, league_driver.tot_pts.to_s,
                                           'font-size' => 30,                 # defaults to 12
                                           'font-family' => 'Monaco',
                                           'stroke-color' => '#ddd',
                                           'color' => 'red',
                                           'font-style' => 'italic',
                                           'font-stretch' => 'expanded',
                                           'font-weight' => 'bold',
                                           'padding' => '30 20 10'
      )
      points_text.apply
      points_text_image = MiniMagick::Image.open(points_text.path)
      _composite = _composite.composite(points_text_image) { |c| c.compose "Over"; c.geometry "+#{driver['pos-x'].to_i+driver['pts-offset'].to_i}+#{driver['pos-y']}" }
    end
    _composite.write("#{background.path.sub(/.png/, '')}-generated.png") # overwrite the old attachment. remove the last .png
    self.composite = Pathname.new("#{background.path.sub(/.png/, '')}-generated.png")
    self.save
  end
end
