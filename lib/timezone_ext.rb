require 'tzinfo'
require "active_support/core_ext"
require "timezone_ext/version"

module TimezoneExt
  def strptime(date, format)
    if format =~ /%z/i
      Time.strptime(date, format).in_time_zone
    else
      Time.strptime("#{date} zone#{name}", "#{format} zone%z").in_time_zone
    end
  end
end

ActiveSupport::TimeZone.send :include, TimezoneExt
