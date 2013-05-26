require 'tzinfo'
require "active_support/core_ext"
require "time_zone_ext/version"

module TimeZoneExt
  def strptime(date, format)
    if format =~ /%z/i
      DateTime.strptime(date, format).in_time_zone
    else
      time_in_zone = DateTime.strptime("#{date} zone#{formatted_offset}", "#{format} zone%z").in_time_zone
      if time_in_zone.formatted_offset != formatted_offset
        DateTime.strptime("#{date} zone#{time_in_zone.formatted_offset}", "#{format} zone%z").in_time_zone
      else
        time_in_zone
      end
    end
  end
end

ActiveSupport::TimeZone.send :include, TimeZoneExt
