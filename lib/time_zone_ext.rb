require 'tzinfo'
require "active_support/core_ext"
require "time_zone_ext/version"

module TimeZoneExt
  def strptime(date, format)
    if format =~ /%z/i
      DateTime.strptime(date, format).in_time_zone
    else
      DateTime.strptime("#{date} zone#{now.strftime('%Z')}", "#{format} zone%Z").in_time_zone
    end
  end
end

ActiveSupport::TimeZone.send :include, TimeZoneExt
