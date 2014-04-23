module TimeConverter
  def parse_time_string(time_string)
    if time_string.include?("L") # the driver is laps down, not a time.
      "#{time_string.to_i}:00:00.000"
    else
      time_string
    end
  end

  def dbtime_to_ms(dbtime)
    md = dbtime.match(/(-\d+):(\d+):(\d+).(\d+)/)
    ms = 0
    ms += md[2].to_i*60000
    ms += md[3].to_i*1000
    ms += md[4].to_i
    md[1].include?("-") ? ms * -1 : ms
  end

  def ms_to_dbtime(_ms)
    _ms < 0 ? sign = "-" : sign = ""
    _ms *= -1
    mins = _ms/60000
    secs = (_ms-mins*60000)/1000
    ms = (_ms-mins*60000-secs*1000)
    "#{sign}#{mins}:#{secs}.#{ms}"
  end
end