module ImageComposer
  def extract_driver_list
    drivers = []
    doc = Nokogiri::HTML(open(url))
    case self.class.to_s
      when 'Result'
        doc.css('table#driver_table tr.jsTableRow').each do |row|
          driver = Driver.new
          driver.pos = row.children[0].text.to_i
          driver.name = row.children[4].text
          driver.tot_pts = row.children[6].text.to_i
          driver.race_pts = row.children[8].text.to_i
          driver.bns_pts = row.children[10].text.to_i
          driver.interval = row.children[12].text
          driver.laps = row.children[14].text
          driver.laps_led = row.children[16].text.to_i
          driver.fastest_lap = row.children[18].text
          driver.fast_lap = row.children[20].text.to_i
          driver.avg_lap = row.children[22].text
          driver.inc = row.children[24].text.to_i
          driver.status = row.children[26].text
          driver.team = row.children[28].text
          drivers << driver
        end
      when 'Standing'
        doc.css('table#driver_table tr.jsTableRow').each do |row|
          driver = Driver.new
          driver.pos = row.children[0].text.to_i
          driver.name = row.children[2].text
          driver.starts = row.children[3].text.to_i
          driver.wins = row.children[4].text.to_i
          driver.top5 = row.children[5].text.to_i
          driver.top10 = row.children[6].text.to_i
          driver.tot_pts = row.children[7].text.to_i
          driver.bns_pts = row.children[8].text.to_i
          driver.laps = row.children[9].text.to_i
          driver.beh_lead = row.children[10].text.to_i
          driver.beh_next = row.children[11].text.to_i
          drivers << driver
        end
    end
    drivers
  end

  def make_image
    if league.config && league.background
      background = league.background
      config = league.config
      _image = MiniMagick::Image.open(background.path)
      config = JSON.parse(config) # read the config
      drivers = extract_driver_list
      config['drivers'].each_with_index do |driver, i|
        # find the driver in the league
        league_driver = drivers[i]
        # generate the name
        driver_name = Dragonfly.app.generate(:text, league_driver.name,
                                             'font-size' => config['general']['font-size'],# defaults to 12
                                             'font' => "#{Rails.root}/public/images/fonts/#{config['general']['font']}",
                                             'color' => config['general']['color'],
                                             'padding' => '30 20 10'
        )
        #driver_name = driver_name.convert('-density 288 -resize 25%')
        driver_name_image = MiniMagick::Image.open(driver_name.path)
        _image = _image.composite(driver_name_image) { |c| c.compose "Over"; c.geometry "+#{driver['pos-x']}+#{driver['pos-y']}" }
        # generate the points
        points_text = Dragonfly.app.generate(:text, league_driver.tot_pts.to_s,
                                             'font-size' => config['general']['font-size'], # defaults to 12
                                             'font' => "#{Rails.root}/public/images/fonts/#{config['general']['font']}",
                                             'color' => config['general']['color'],
                                             'padding' => '30 20 10'
                                             #'stroke-color' => '#ddd',
                                             #'font-style' => 'italic',
                                             #'font-stretch' => 'expanded',
                                             #'font-weight' => 'bold',
        )
        points_text.apply
        points_text_image = MiniMagick::Image.open(points_text.path)
        _image = _image.composite(points_text_image) { |c| c.compose "Over"; c.geometry "+#{driver['pos-x'].to_i+driver['pts-offset'].to_i}+#{driver['pos-y']}" }
      end
      _image.write("#{background.path.sub(/.png/, '')}-generated.png") # overwrite the old attachment. remove the last .png
      self.image = Pathname.new("#{background.path.sub(/.png/, '')}-generated.png")
      self.status = 'ok'
      self.save
    end
  end

  def generate_preview
    # load sample data.
    drivers = JSON.parse(File.read("#{Rails.root}/driver-samples.json"))["drivers"]
    #if config && background
    canvas = MiniMagick::Image.open(background.path)
    parsed_config = JSON.parse(config)
    font_attributes = {   'font-size' => parsed_config["general"]["font-size"],
                          'color' => parsed_config["general"]["color"],
                          'font' => "#{Rails.root}/public/images/fonts/#{parsed_config["general"]["font"]}",
                          'line-height' => parsed_config["general"]["line-height"]
                      }
    line_height = parsed_config["general"]["line-height"]
    parsed_config["general"]["entries"].times do |i|
      if parsed_config["general"]["scores"]
        x = parsed_config["scores"]["x-pos"]
        y = parsed_config["scores"]["y-pos"]+(i*line_height)
        score = Dragonfly.app.generate(:text, drivers[i]["Points"].to_s, font_attributes)
        score_image = MiniMagick::Image.open(score.path)
        canvas = canvas.composite(score_image) { |c| c.compose "Over"; c.geometry "+#{x}+#{y}" }
      end
      if parsed_config["general"]["positions"]
        x = parsed_config["positions"]["x-pos"]
        y = parsed_config["positions"]["y-pos"]+(i*line_height)
        position = Dragonfly.app.generate(:text, drivers[i]["Pos"].to_s, font_attributes)
        position_image = MiniMagick::Image.open(position.path)
        canvas = canvas.composite(position_image) { |c| c.compose "Over"; c.geometry "+#{x}+#{y}" }
      end
      x = parsed_config["drivers"]["x-pos"]
      y = parsed_config["drivers"]["y-pos"]+(i*line_height)
      driver_name = Dragonfly.app.generate(:text, drivers[i]["Driver"].to_s, font_attributes)
      driver_name_image = MiniMagick::Image.open(driver_name.path)
      canvas = canvas.composite(driver_name_image) { |c| c.compose "Over"; c.geometry "+#{x}+#{y}" }
    end
    canvas.write("#{background.path.sub(/.png/, '')}-generated.png") # overwrite the old attachment. remove the last .png
    self.update_attribute(:preview, Pathname.new("#{background.path.sub(/.png/, '')}-generated.png"))
    #self.save
    #end
=begin
    if config && background
      _image = MiniMagick::Image.open(background.path)
      _config = JSON.parse(config) # read the config

      _config['drivers'].each_with_index do |driver, i|
        # find the driver in the league
        league_driver = drivers[i]
        # generate the name
        driver_name = Dragonfly.app.generate(:text, "league_driver["name"]",
                                                                        'font-size' => _config['general']['font-size'],# defaults to 12
                                                                        'font' => "#{Rails.root}/public/images/fonts/#{_config['general']['font']}",
                                                                        'color' => _config['general']['color'],
                                                                        'padding' => '30 20 10'
        )
        #driver_name = driver_name.convert('-density 288 -resize 25%')
        driver_name_image = MiniMagick::Image.open(driver_name.path)
        _image = _image.composite(driver_name_image) { |c| c.compose "Over"; c.geometry "+#{driver['pos-x']}+#{driver['pos-y']}" }
        # generate the points
        points_text = Dragonfly.app.generate(:text, league_driver["score"].to_s,
                                             'font-size' => _config['general']['font-size'], # defaults to 12
                                             'font' => "#{Rails.root}/public/images/fonts/#{_config['general']['font']}",
                                             'color' => _config['general']['color'],
                                             'padding' => '30 20 10'
        #'stroke-color' => '#ddd',
        #'font-style' => 'italic',
        #'font-stretch' => 'expanded',
        #'font-weight' => 'bold',
        )
        points_text.apply
        points_text_image = MiniMagick::Image.open(points_text.path)
        _image = _image.composite(points_text_image) { |c| c.compose "Over"; c.geometry "+#{driver['pos-x'].to_i+driver['pts-offset'].to_i}+#{driver['pos-y']}" }
      end
      _image.write("#{background.path.sub(/.png/, '')}-generated.png") # overwrite the old attachment. remove the last .png
      self.preview = Pathname.new("#{background.path.sub(/.png/, '')}-generated.png")
      self.status = 'ok'
      self.save
    end
=end
  end
end