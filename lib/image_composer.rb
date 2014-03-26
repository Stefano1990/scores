module ImageComposer
  def extract_driver_list
    drivers = []
    doc = Nokogiri::HTML(open(url))
    max_drivers = @config['general']['entries']
    case self.class.to_s
      when 'Result'
        doc.css('table#driver_table tr.jsTableRow').each_with_index do |row,i|
          if i < max_drivers
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
          else
            break
          end
        end
      when 'Standing'
        doc.css('table#driver_table tr.jsTableRow').each_with_index do |row,i|
          if i < max_drivers
            driver = Driver.new
            driver.pos = row.children[0].text.to_i
            driver.name = row.children[1].text
            driver.team = row.children[2].text
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
          else
            break
          end
        end
    end
    drivers
  end

  def make_image
    if league.config && league.background
      background = league.background
      @config = JSON.parse(league.config)
      @canvas = MiniMagick::Image.open(background.path)
      @drivers = extract_driver_list

      @font_attributes = {   'font_size' => @config["general"]["font_size"],
                             'color' => @config["general"]["color"],
                             'font' => "#{Rails.root}/public/images/fonts/#{@config["general"]["font"]}",
                         }
      compose_sub_image('pos','positions') if @config["general"]['positions']
      compose_sub_image('name','names') if @config["general"]['names']
      compose_sub_image('team','teams') if @config["general"]['teams']
      compose_sub_image('tot_pts','scores') if @config["general"]['scores']

      @canvas.write("#{background.path.sub(/.png/, '')}-generated.png") # overwrite the old attachment. remove the last .png
      self.image = Pathname.new("#{background.path.sub(/.png/, '')}-generated.png")
      self.status = 'ok'
      self.save
      #
      #  x = parsed_config["positions"]["x-pos"]
      #  string = ""
      #  font_attributes['color'] = parsed_config["positions"]["color"] || font_attributes['color']
      #  drivers.each{|d| string << "#{d["Pos"]}\n" }
      #  positions = Dragonfly.app.generate(:multiline,string,font_attributes)
      #  positions_image = MiniMagick::Image.open(positions.path)
      #  canvas = canvas.composite(positions_image) { |c| c.compose "Over"; c.geometry "+#{x}+#{y}" }
      #if parsed_config["general"]["teams"]
      #  compose_sub_image(drivers, "teams")
      #  x = parsed_config["teams"]["x-pos"]
      #  string = ""
      #  drivers.each{|d| string << "#{d["Team"]}\n" }
      #  font_attributes['color'] = "#FFFFFF"
      #  teams = Dragonfly.app.generate(:multiline,string,font_attributes)
      #  teams_image = MiniMagick::Image.open(teams.path)
      #  canvas = canvas.composite(teams_image) { |c| c.compose "Over"; c.geometry "+#{x}+#{y}" }
      #end
      #
      #config['drivers'].each_with_index do |driver, i|
      #  # find the driver in the league
      #  league_driver = drivers[i]
      #  # generate the name
      #  driver_name = Dragonfly.app.generate(:text, league_driver.name,
      #                                       'font-size' => config['general']['font-size'],# defaults to 12
      #                                       'font' => "#{Rails.root}/public/images/fonts/#{config['general']['font']}",
      #                                       'color' => config['general']['color'],
      #                                       'padding' => '30 20 10'
      #  )
      #  #driver_name = driver_name.convert('-density 288 -resize 25%')
      #  driver_name_image = MiniMagick::Image.open(driver_name.path)
      #  _image = _image.composite(driver_name_image) { |c| c.compose "Over"; c.geometry "+#{driver['pos-x'].to_s}+#{driver['pos-y'].to_s}" }
      #  # generate the points
      #  points_text = Dragonfly.app.generate(:text, league_driver.tot_pts.to_s,
      #                                       'font-size' => config['general']['font-size'], # defaults to 12
      #                                       'font' => "#{Rails.root}/public/images/fonts/#{config['general']['font']}",
      #                                       'color' => config['general']['color'],
      #                                       'padding' => '30 20 10'
      #                                       #'stroke-color' => '#ddd',
      #                                       #'font-style' => 'italic',
      #                                       #'font-stretch' => 'expanded',
      #                                       #'font-weight' => 'bold',
      #  )
      #  points_text.apply
      #  points_text_image = MiniMagick::Image.open(points_text.path)
      #  _image = _image.composite(points_text_image) { |c| c.compose "Over"; c.geometry "+#{driver['pos-x'].to_i+driver['pts-offset'].to_i}+#{driver['pos-y']}" }
      #end
      #_image.write("#{background.path.sub(/.png/, '')}-generated.png") # overwrite the old attachment. remove the last .png
      #self.image = Pathname.new("#{background.path.sub(/.png/, '')}-generated.png")
      #self.status = 'ok'
      #self.save
    end
  end

  def generate_preview
    # load sample data.
    all_drivers = JSON.parse(File.read("#{Rails.root}/driver-samples.json"))["drivers"]
    #if config && background
    canvas = MiniMagick::Image.open(background.path)
    parsed_config = JSON.parse(config)
    font_attributes = {   'font_size' => parsed_config["general"]["font-size"],
                          'color' => parsed_config["general"]["color"],
                          'font' => "#{Rails.root}/public/images/fonts/#{parsed_config["general"]["font"]}",
                          #'line-height' => parsed_config["general"]["line-height"]
                      }
    y = parsed_config["general"]["y-pos"]
    drivers = []
    parsed_config["general"]["entries"].times {|i| drivers << all_drivers[i] }
    if parsed_config["general"]["positions"]
      x = parsed_config["positions"]["x-pos"]
      string = ""
      font_attributes['color'] = parsed_config["positions"]["color"] || font_attributes['color']
      drivers.each{|d| string << "#{d["Pos"]}\n" }
      positions = Dragonfly.app.generate(:multiline,string,font_attributes)
      positions_image = MiniMagick::Image.open(positions.path)
      canvas = canvas.composite(positions_image) { |c| c.compose "Over"; c.geometry "+#{x}+#{y}" }
    end
    if parsed_config["general"]["teams"]
      x = parsed_config["teams"]["x-pos"]
      string = ""
      drivers.each{|d| string << "#{d["Team"]}\n" }
      font_attributes['color'] = "#FFFFFF"
      teams = Dragonfly.app.generate(:multiline,string,font_attributes)
      teams_image = MiniMagick::Image.open(teams.path)
      canvas = canvas.composite(teams_image) { |c| c.compose "Over"; c.geometry "+#{x}+#{y}" }
    end
    if parsed_config["general"]["scores"]
      x = parsed_config["scores"]["x-pos"]
      string = ""
      drivers.each{|d| string << "#{d["Points"]}\n" }
      scores = Dragonfly.app.generate(:multiline,string,font_attributes)
      score_image = MiniMagick::Image.open(scores.path)
      canvas = canvas.composite(score_image) { |c| c.compose "Over"; c.geometry "+#{x}+#{y}" }
    end
    x = parsed_config["names"]["x-pos"]
    string = ""
    drivers.each{|d| string << "#{d["Driver"]}\n" }
    names = Dragonfly.app.generate(:multiline,string,font_attributes)
    names_image = MiniMagick::Image.open(names.path)
    canvas = canvas.composite(names_image) { |c| c.compose "Over"; c.geometry "+#{x}+#{y}" }

    canvas.write("#{background.path.sub(/.png/, '')}-generated.png") # overwrite the old attachment. remove the last .png
    self.update_attribute(:preview, Pathname.new("#{background.path.sub(/.png/, '')}-generated.png"))
  end

  def compose_sub_image(model_attribute,config_attribute)
    string = ""
    font_attributes = combine_font_properties(config_attribute)
    @drivers.each{|driver| string << "#{driver.send(model_attribute)}\n" }
    x = @config[config_attribute]["x-pos"]
    y = @config['general']['y-pos']
    sub_image_job = Dragonfly.app.generate(:multiline,string,font_attributes)
    sub_image = MiniMagick::Image.open(sub_image_job.path)
    @canvas = @canvas.composite(sub_image) { |c| c.compose "Over"; c.geometry "+#{x}+#{y}" }
  end

  def combine_font_properties(attribute)
    font_attributes = {}
    font_atts = ['font','color','font_size']
    font_atts.each do |font_attribute|
      font_attributes[font_attribute] = @config[attribute][font_attribute] || @font_attributes[font_attribute]
    end
    font_attributes
  end
end