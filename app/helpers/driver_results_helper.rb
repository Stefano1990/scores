module DriverResultsHelper
  def pretty_interval(interval)
    md = interval.match(/(-?\d*):(\d*):(\d*).(\d*)/)
    if interval == "00:00:00"
      output = "---"
    else
      if md[1] != "-00" # The driver is laps down so example "-12"
        if md[1] == "-01" # one lap
          output = "#{md[1].to_i} lap"
        else
          output = "#{md[1].to_i} laps"
        end
      else
        # the driver is time down.
        output = "-#{md[2]}:#{md[3]}.#{md[4]}"
      end
    end
    output
  end
end
