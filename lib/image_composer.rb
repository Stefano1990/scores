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
                                             #'font' => 'Roboto',
                                             'color' => config['general']['color'],
                                             'padding' => '30 20 10'
        )
        driver_name = driver_name.convert('-density 288 -resize 25%')
        driver_name_image = MiniMagick::Image.open(driver_name.path)
        _image = _image.composite(driver_name_image) { |c| c.compose "Over"; c.geometry "+#{driver['pos-x']}+#{driver['pos-y']}" }
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
        _image = _image.composite(points_text_image) { |c| c.compose "Over"; c.geometry "+#{driver['pos-x'].to_i+driver['pts-offset'].to_i}+#{driver['pos-y']}" }
      end
      _image.write("#{background.path.sub(/.png/, '')}-generated.png") # overwrite the old attachment. remove the last .png
      self.image = Pathname.new("#{background.path.sub(/.png/, '')}-generated.png")
      self.status = 'ok'
      self.save
    end
  end
end