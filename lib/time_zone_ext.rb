require 'tzinfo'
require "active_support/core_ext"
require "time_zone_ext/version"

module TimeZoneExt
  def strptime(date, format)
    if format =~ /%z/i
      DateTime.strptime(date, format).in_time_zone
    else
      parsed_time = Time.strptime(date_time_string, format)
      ActiveSupport::TimeWithZone.new(nil, Time.zone, parsed_time)
    end
  end
end

ActiveSupport::TimeZone.send :include, TimeZoneExt
