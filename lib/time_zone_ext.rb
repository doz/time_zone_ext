require 'tzinfo'
require "active_support/core_ext"
require "time_zone_ext/version"

module TimeZoneExt
  def strptime(date, format)
    #TODO: rewrite using lower level functions
    if format =~ /%z/i
      Time.strptime(date, format).in_time_zone
    else
      Time.strptime("#{date} zone#{name}", "#{format} zone%z").in_time_zone
    end
  end
end

ActiveSupport::TimeZone.send :include, TimeZoneExt
