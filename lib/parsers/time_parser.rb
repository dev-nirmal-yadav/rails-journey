# frozen_string_literal: true

# Parses Time formats in required formats.
class TimeParser
  def self.diff_between(start_time, end_time)
    Time.parse(start_time) - Time.parse(end_time)
  end

  def self.in_hours(seconds)
    Time.at(seconds).utc.strftime('%H hours %M minutes')
  end

  def self.in_datetime(datetime)
    Time.parse(datetime).strftime('%d/%m/%Y %I:%M%p %z')
  end
end
