class Standing < ActiveRecord::Base


  belongs_to :result, class_name: 'Result', foreign_key: 'result_id'
  belongs_to :season

  has_many        :drivers, through: :result, uniq: true
  has_many        :driver_standings, order: 'tot_pts desc', uniq: true
  has_many        :team_standings, order: 'tot_pts desc', uniq: true
  has_many        :teams, through: :team_standings, uniq: true
  has_many        :driver_standing_graphics, class_name: "DriverStandingGraphic"
  has_many        :team_standing_graphics, class_name: "TeamStandingGraphic"

  delegate        :series, to: :result
  delegate        :league, to: :result
  delegate        :season, to: :result

  attr_accessible   :result

  after_save      :generate_standings
  after_save      :generate_graphics

  def recalculate
    driver_standings.destroy_all
    generate_standings
  end

  def generate_standings
    driver_results = DriverResult.where(result_id: included_results)
    generate_driver_standings(driver_results)
    generate_team_standings
  end

  def generate_graphics
    # check how many graphics we need.
    entries = JSON.parse(season.config)['general']['entries']
    # Drivers
    nr_of_graphics = (driver_standings.count.to_f/entries.to_f).ceil
    nr_of_graphics.times do |i|
      first_pos = (entries*i)+1
      last_pos = entries*i
      driver_standing_graphic = driver_standing_graphics.create(first_pos: first_pos, last_pos: last_pos)
      driver_standing_graphic.create_image(i,nr_of_graphics)
    end
    # Teams
    nr_of_graphics = (team_standings.count.to_f/entries.to_f).ceil
    nr_of_graphics.times do |i|
      first_pos = (entries*i)+1
      last_pos = entries*i
      if team_standing.team
        team_standing_graphic = team_standing_graphics.create(first_pos: first_pos, last_pos: last_pos)
        team_standing_graphic.create_image(i,nr_of_graphics)
      end
    end
  end

  def generate_driver_standings(driver_results)
    drivers.each do |driver|
      driver_standing = driver_standings.new
      driver_standing.driver = driver
      driver_standing.race_pts = driver_results.where(driver_id: driver.id).sum(:race_pts)
      driver_standing.bns_pts = driver_results.where(driver_id: driver.id).sum(:bns_pts)
      driver_standing.tot_pts = driver_standing.race_pts + driver_standing.bns_pts.to_i
      driver_standing.laps_comp = driver_results.where(driver_id: driver.id).sum(:laps_comp)
      driver_standing.laps_led = driver_results.where(driver_id: driver.id).sum(:laps_led)
      driver_standing.inc = driver_results.where(driver_id: driver.id).sum(:inc)
      #driver_standing.penalty_pts = driver_results_for_driver(driver).sum(:inc)
      driver_standing.team = driver.team_for_season(season)
      driver_standing.starts = driver_results.where(driver_id: driver.id).count
      driver_standing.save
    end

    driver_standings.reload.each_with_index do |driver_standing,i|
      driver_standing.pos = i+1
      driver_standing.save
    end
  end

  def generate_team_standings
    team_results = TeamResult.where(result_id: included_results)
    team_results.each do |team_result|
      team_standing = team_standings.find_or_initialize_by_team_id(team_result.team_id)
      [:race_pts,:bns_pts,:laps_comp,:laps_led,:inc,:starts].each do |att|
        team_standing[att] = team_results.where(team_id: team_result.team_id).sum(att)
      end
      team_standing.tot_pts = team_standing.race_pts + team_standing.bns_pts
      team_standing.save
    end

    team_standings.reload.each_with_index do |team_standing,i|
      team_standing.pos = i+1
      team_standing.save
    end
  end

  def included_results
    season.results.where("id <= ?", result_id)
  end

  def driver_results_for_driver(driver)
    DriverResult.where(driver_id: driver.id, result_id: included_results.pluck(:id))
  end

  #########################
  #  OLD STANDING CODE    #
  #########################

  #include ImageComposer
  #belongs_to    :graphic

  #has_one     :standing_config
  #dragonfly_accessor :background
  #dragonfly_accessor :composite
  #dragonfly_accessor :image
  #attr_accessible :background_name, :background_uid, :league_id, :background, :standing_config
  #attr_accessible   :graphic_id, :image_name, :image_uid, :url
  #validate          :url, :check_url
  #
  #after_create      :make_image
  #
  #def check_url
  #  if !(url =~ /season_race/).nil?
  #    errors.add(:url, "please check your url. This URL looks like a results URL.")
  #  end
  #end
end
