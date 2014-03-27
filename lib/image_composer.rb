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
            driver.name = row.children[2].text
            driver.team = row.children[3].text
            driver.starts = row.children[4].text.to_i
            driver.wins = row.children[7].text.to_i
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
      @font_attributes = font_attributes_hash
      compose_sub_image('pos','positions') if @config["general"]['positions']
      compose_sub_image('name','names') if @config["general"]['names']
      compose_sub_image('team','teams') if @config["general"]['teams']
      compose_sub_image('tot_pts','scores') if @config["general"]['scores']

      @canvas.write("#{background.path.sub(/.png/, '')}-generated.png") # overwrite the old attachment. remove the last .png
      self.image = Pathname.new("#{background.path.sub(/.png/, '')}-generated.png")
      image.to_file("#{Rails.root}/public/system/dragonfly/#{Rails.env}/#{id}.png")
      self.image_public_url = "/system/dragonfly/#{Rails.env}/#{id}.png"
      self.status = 'ok'
      self.save
    end
  end

  def generate_preview
    @config = JSON.parse(config)
    # load sample data.
    driver_data = JSON.parse(File.read("#{Rails.root}/driver-samples.json"))["drivers"]
    @drivers = []
    driver_data.each_with_index do |d,i|
      if i < @config['general']['entries']
        @drivers.push(Driver.new(name: d['Driver'], pos: d['Pos'], team: d['Team'], tot_pts: d['Points']))
      end
    end
    #if config && background
    @canvas = MiniMagick::Image.open(background.path)
    @font_attributes = font_attributes_hash
    compose_sub_image('pos','positions') if @config["general"]['positions']
    compose_sub_image('name','names') if @config["general"]['names']
    compose_sub_image('team','teams') if @config["general"]['teams']
    compose_sub_image('tot_pts','scores') if @config["general"]['scores']

    @canvas.write("#{background.path.sub(/.png/, '')}-generated.png")
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
    if @config[attribute]['font']
      font_attributes['font'] = "#{Rails.root}/public/images/fonts/#{@config[attribute]['font']}"
    else
      font_attributes['font'] = "#{Rails.root}/public/images/fonts/#{@config['general']['font']}"
    end
    font_attributes['color'] = @config[attribute]['color'] || @font_attributes['color']
    font_attributes['font_size'] = @config[attribute]['font_size'] || @font_attributes['font_size']
    font_attributes['interline-spacing'] = @config[attribute]['interline-spacing'] || @font_attributes['interline-spacing']
    font_attributes
  end

  def font_attributes_hash
    {
        'font_size' => @config["general"]["font_size"],
        'color' => @config["general"]["color"],
        'font' => "#{Rails.root}/public/images/fonts/#{@config["general"]["font"]}",
        'interline-spacing' => @config["general"]["interline-spacing"] || @config['general']['font_size'],
    }
  end
end