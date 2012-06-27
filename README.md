# TimeZoneExt

`ActiveSupport::TimeZone` class defines almost every method you need to handle time.
Thus providing you with convenient means (`Time.zone.now`, `Time.zone.parse(str)`, etc.) to get time in current time zone.

When you get time string from an external service and `parse` can't handle it you need to use `strptime` method.
But ActiveSupport doesn't define `strptime` method. Let's add this method that will do timezone magic for you.

## Installation

Add this line to your application's Gemfile:

    gem 'time_zone_ext'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install time_zone_ext

## Usage

If you parse time string that already includes timezone information `Time.zone.strptime` will return this time in current timezone.
```ruby
Time.zone = 'EST'
Time.zone.strptime("2012-06-02 00:00 UTC", "%Y-%m-%d %H:%M %Z")
# => Fri, 01 Jun 2012 19:00:00 EST -05:00
```

If you parse string without explicitly specified timezone, it will be treated as defined in current timezone.
```ruby
Time.zone = 'EST'
Time.zone.strptime("2012-06-02 00:00", "%Y-%m-%d %H:%M")
# => Sat, 02 Jun 2012 00:00:00 EST -05:00
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Copyright

Copyright (c) 2012 Alexander Danilenko. See LICENSE.txt for further details.