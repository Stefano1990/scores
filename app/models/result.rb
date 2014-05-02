require 'csv'

class Result < ActiveRecord::Base
  include ImageComposer

  belongs_to          :season
  has_many            :driver_results, order: 'fin_pos asc, interval desc', dependent: :destroy
  has_many            :drivers, through: :driver_results
  has_many            :team_results, dependent: :destroy
  has_many            :teams, through: :drivers, uniq: true
  #has_many            :penalties, dependent: :destroy

  #dragonfly_accessor  :image
  attr_accessible     :url, :csv, :parsed_csv_string, :season_id, :image_name, :image_uid, :first_entry, :last_entry
  attr_accessor       :csv
  attr_accessor       :parsed_csv_string

  #after_create        :make_image
  #before_save         :get_meta_data
  after_save         :parse_results      #

  delegate        :series, to: :season
  delegate        :league, to: :season


  # before changing the data structure around these were attributes on this model:
  #remove_column :results, :graphic_id
  #remove_column :results, :image_name
  #remove_column :results, :image_uid
  #remove_column :results, :image_public_url
  #remove_column :results, :first_entry
  #remove_column :results, :last_entry
  #remove_column :results, :track_image_url
  #remove_column :results, :url

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

  def parse_results
    prepare_csv
    parse_csv_string
    calculate_team_results
  end

  # class methods for playing around.
  def prepare_csv
    unparsed_file = File.open(csv.path)
    self.parsed_csv_string = ""
    string = unparsed_file.readlines()
    string.each_with_index do |line,i|
      parsed_line = line.encode('UTF-8', 'binary', invalid: :replace, undef: :replace, replace: '').gsub(/,\"\"/,'')
      # for some reason the iRacing CSV file is buggy.
      unless parsed_line == "\n"
        if i == 5 or i == 6
          parsed_line = parsed_line.gsub(/\n/,"\r\n")
        end
        self.parsed_csv_string << parsed_line
      end
    end
    unparsed_file.close
  end

  def parse_csv_string
    line_nr = 0
    ::CSV.parse(parsed_csv_string,headers:false,col_sep: ",") do |line|
      case line_nr
        when 0
        when 1
          self.start_time = Time.parse(line[0])
          self.track = line[1]
          self.hosted_session_name = line[2]
        when 2
        when 3
          self.league_name = line[0]
          self.iracing_league_id = line[1]
          self.league_season = line[2]
          self.league_season_id = line[3]
          self.points_system = line[4]
        when 4
        else
          # driver
          driver_result = self.driver_results.new
          driver_result.fin_pos = line[0].to_i
          driver_result.car_id = line[1].to_i
          driver_result.car = line[2]
          driver_result.car_class_id = line[3].to_i
          driver_result.car_class = line[4]
          driver_result.cust_id = line[5].to_i
          driver_result.name = line[6]
          driver_result.start_pos = line[7].to_i
          driver_result.car_nr = line[8]
          driver_result.out_id = line[9].to_i
          driver_result.out = line[10]
          driver_result.interval = driver_result.parse_time_string(line[11])
          driver_result.laps_led = line[12].to_i
          driver_result.average_lap_time = driver_result.parse_time_string(line[13])
          driver_result.fastest_lap_time = driver_result.parse_time_string(line[14])
          driver_result.fast_lap_nr = line[15]
          driver_result.laps_comp = line[16]
          driver_result.inc = line[17]
          driver_result.league_points = line[18]
          driver_result.find_driver
          driver_result.find_team
          driver_result.save
      end
      line_nr = line_nr + 1
    end
  end

  def calculate_team_results
    driver_results.each do |driver_result|
      team_result = team_results.find_or_initialize_by_team_id(driver_result.team_id)
      team_result.laps_led += driver_result.laps_led.to_i
      team_result.laps_comp += driver_result.laps_comp.to_i
      team_result.inc += driver_result.inc.to_i
      #team_result.league_points += driver_result.laps_led
      team_result.race_pts += driver_result.race_pts.to_i
      team_result.bns_pts += driver_result.bns_pts.to_i
      team_result.save
    end
  end

  def recalculate
    driver_results.each_with_index do |driver_result,i|
      driver_result.update_attribute(:fin_pos, i+1)
    end
  end

  def result_for_driver(driver)
    driver_results.find_by_driver_id(driver.id)
  end
end
