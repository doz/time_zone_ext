# -*- encoding: utf-8 -*-
require File.expand_path('../lib/time_zone_ext/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Alexander Danilenko"]
  gem.email         = ["alexander@danilenko.org"]
  gem.description   = "Adds #strptime method to ActiveSupport::TimeZone"
  gem.summary       = "Defines Time.zone.strptime"
  gem.homepage      = "https://github.com/doz/time_zone_ext"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "time_zone_ext"
  gem.require_paths = ["lib"]
  gem.version       = TimeZoneExt::VERSION

  gem.add_development_dependency "rspec"
  gem.add_dependency "activesupport"
  gem.add_dependency "tzinfo"
end
