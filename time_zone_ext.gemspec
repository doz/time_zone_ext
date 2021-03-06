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

  # Rails 5 dropped support for Ruby < 2.2.2
  # Rails 4 dropped support for Ruby < 1.9.3
  # dependency i18n 0.7 require RUBY_VERSION >= 1.9.3
  # rake 11 require RUBY_VERSION >= 1.9.3
  if RUBY_VERSION < '1.9.3'
    gem.add_development_dependency 'rake', '< 11'
    gem.add_development_dependency 'i18n', '< 0.7'
    gem.add_dependency 'activesupport', '< 4'
  elsif RUBY_VERSION < '2.2.2'
    gem.add_development_dependency 'rake'
    gem.add_dependency 'activesupport', '< 5'
  else
    gem.add_development_dependency 'rake'
    gem.add_dependency 'activesupport'
  end

  gem.add_dependency "tzinfo"
end
