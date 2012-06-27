require "timezone_ext/version"

module TimezoneExt
end

if defined?(Rails::Railtie)
  require "timezone_ext/railtie"
elsif defined?(Rails::Initializer)
  raise "Sorry, timezone_ext is not compatible with Rails 2.3 or older"
end
