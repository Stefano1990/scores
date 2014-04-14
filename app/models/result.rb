require 'csv'

class Result < ActiveRecord::Base
  include ImageComposer


  belongs_to          :season
  dragonfly_accessor  :image
  attr_accessible     :url, :csv, :parsed_csv_string, :season_id, :image_name, :image_uid, :first_entry, :last_entry
  attr_accessor       :csv
  attr_accessor       :parsed_csv_string
  validate             :url, :check_url

  #after_create        :make_image
  #before_save         :get_meta_data
  before_save         :parse_results

  # before changing the data structure around these were attributes on this model:
  #remove_column :results, :graphic_id
  #remove_column :results, :image_name
  #remove_column :results, :image_uid
  #remove_column :results, :image_public_url
  #remove_column :results, :first_entry
  #remove_column :results, :last_entry
  #remove_column :results, :track_image_url
  #remove_column :results, :url

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

  def parse_results
    prepare_csv
    parse_csv_string
  end

  # class methods for playing around.
  def prepare_csv
    unparsed_file = File.open(csv.path)
    self.parsed_csv_string = ""
    string = unparsed_file.readlines()
    string.each_with_index do |line,i|
      parsed_line = line.gsub(/,\"\"/,'')
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
          self.league_id = line[1]
          self.league_season = line[2]
          self.league_season_id = line[3]
          self.points_system = line[4]
        when 4
        else
          # driver
      end
      line_nr = line_nr + 1
      a
    end
  end
end
