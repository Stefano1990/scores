class Penalty < ActiveRecord::Base
  include TimeConverter
  attr_accessible :disqualification, :driver_result_id, :time, :one_sec, :two_sec, :five_sec, :ten_sec, :twenty_sec, :thirty_sec, :one_grid, :three_grid, :five_grid, :ten_grid
  attr_accessor   :time
  belongs_to      :driver_result
  delegate        :result, to: :driver_result
  delegate        :season, to: :driver_result
  delegate        :series, to: :driver_result
  delegate        :league, to: :driver_result
  delegate        :driver, to: :driver_result

  PENALTY_STRINGS = [['one_sec','1 second'],['two_sec','2 seconds'],['five_sec','5 seconds'],['ten_sec','10 seconds'],
                     ['twenty_sec','20 seconds'],
                     ['thirty_sec','30 seconds'],['one_grid','1 grid place'],['three_grid','3 grid places'],
                     ['five_grid','5 grid places'],['ten_grid','10 grid places']]

  #before_save     :timestring_to_dbtime
  #before_save      :convert_penalties_to_time

  def timestring_to_dbtime
    _time = time.to_i
    mins = _time.to_i/60000
    secs = (_time-mins*60000)/1000
    ms = (_time-mins*60000-secs*1000)
    self.time = "#{mins}:#{secs}.#{ms}"
  end

  # TODO: Change this to DB fields.

  def sum_times
    time = 0
    time = 1000 if one_sec
    time += 2000 if two_sec
    time += 5000 if five_sec
    time += 10000 if ten_sec
    time += 30000 if thirty_sec
    time
  end

  def sum_grid_pos
    pos = 0
    pos += 1 if one_grid
    pos += 2 if two_grid
    pos += 3 if three_grid
    pos += 5 if five_grid
    pos += 10 if ten_grid
    pos
  end

  def apply
    if disqualification
      driver_result.disqualify
    else
      new_interval = driver_result.period_to_milliseconds(driver_result.interval) - sum_times
      driver_result.interval = driver_result.milliseconds_to_dbtime(new_interval)
    end
    driver_result.fin_pos = driver_result.fin_pos + sum_grid_pos
    driver_result.save
    driver_result.result.recalculate
  end
end
