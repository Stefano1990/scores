class DriverResult < ActiveRecord::Base
  attr_accessible :driver_id, :result_id,  :result_id, :driver_id, :fin_pos, :car_id, :car,
                  :car_class_id, :car_class, :cust_id, :name, :start_pos, :car_nr, :out_id,
                  :out, :interval, :laps_led, :average_lap_time, :fastest_lap_time, :fast_lap_nr,
                  :laps_comp, :inc, :league_points, :bns_pts, :race_pts, :lap_led, :fastest_lap, :pole_position
  belongs_to      :driver
  belongs_to      :result
  belongs_to      :team
  has_many        :penalties, dependent: :destroy
  delegate        :season, to: :result
  delegate        :series, to: :result
  delegate        :league, to: :result
  delegate        :team_for_season, to: :driver
  delegate        :point_system, to: :season

  before_save     :lookup_race_pts
  before_save     :calculate_bns_pts

  def find_driver
    driver = Driver.find_by_customer_id(cust_id)
    if driver.nil?
      driver = Driver.create(customer_id: cust_id, name: name)
    end
    self.driver = driver
  end

  def find_team
    self.team = driver.team_for_season(season)
  end

  def team_name_for_season(season)
    begin
      driver.team_for_season(season).name
    rescue NoMethodError
      ''
    end
  end

  def parse_time_string(time_string)
    if time_string.include?("L") # the driver is laps down, not a time.
      "#{time_string.to_i}:00:00.000"
    else
      time_string
    end
  end

  def period_to_milliseconds(string)
    if string == "00:00:00"
      ms = 0
    else
      md = string.match(/(-\d*):(\d*):(\d*).(\d*)/)
      ms = 0
      ms += md[1].to_i*3600000
      ms += md[2].to_i*60000
      ms += md[3].to_i*1000
      ms += md[4].to_i
      md[1].include?("-") ? ms * -1 : ms
    end
    ms
  end

  def milliseconds_to_dbtime(time)
    time < 0 ? sign = "-" : sign = ""
    time *= -1
    hours = time/3600000
    mins = (time-hours*3600000)/60000
    secs = (time-hours*3600000-mins*60000)/1000
    ms = (time-hours*3600000-mins*60000-secs*1000)
    "#{sign}#{hours}:#{mins}:#{secs}.#{ms}"
  end

  def disqualify
    self.out_id = 29
    self.out = "Disqualified"
    self.interval = milliseconds_to_dbtime(period_to_milliseconds(interval) - 60*60*1000)
  end

  def total_pts
    race_pts + bns_pts.to_i
  end

  def lookup_race_pts
    self.race_pts = point_system.pts_for(fin_pos)
  end

  def calculate_bns_pts
    bns_pts = 0
    bns_pts += point_system.fastest_lap if fastest_lap
    bns_pts += point_system.lap_led if lap_led
    bns_pts += point_system.pole_position if pole_position
    self.bns_pts = bns_pts
  end
end
