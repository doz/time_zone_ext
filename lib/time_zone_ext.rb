require 'tzinfo'
require "active_support/core_ext"
require "time_zone_ext/version"
require "date"
require "i18n"

module TimeZoneExt
  def strptime(date, format, locale: I18n.locale)
    locale ||= I18n.config.locale
    if format =~ /%z/i
      DateTime.strptime(unlocalize_date_string(date,locale), format).in_time_zone
    else
      time_in_zone = DateTime.strptime(unlocalize_date_string("#{date} zone#{formatted_offset}",locale), "#{format} zone%z").in_time_zone
      if time_in_zone.formatted_offset != formatted_offset
        DateTime.strptime(unlocalize_date_string("#{date} zone#{time_in_zone.formatted_offset}",locale), "#{format} zone%z").in_time_zone
      else
        time_in_zone
      end
    end
  end

  # This method converts preffered language month names to
  # English month names based on the locale passed .
  # https://github.com/karnov/i18n-date
  def unlocalize_date_string(string, locale = nil)
      locale ||= I18n.config.locale
      I18n.enforce_available_locales!(locale)
      CONVERTIONS.reduce(string) do |s, (type, replacements)|
        tmp_array = Array.new
        date_map = {}
        map = I18n.t(type, scope: "date", locale: locale)
        map.each { |r| tmp_array.push(r.to_s.gsub('.','')) }
        map = tmp_array.zip(replacements).to_h.tap { |h| h.delete("") }
        map.collect{|k , v| s.include?(k) ? date_map.merge!({s.split(' ', 2).first => v}) :  date_map.merge!({k =>  v})}
        s.gsub(/\b(#{date_map.keys.join("|") })\b/) {|match| date_map[match] }
      end
  end

  CONVERTIONS = {
      month_names: ::Date::MONTHNAMES,
      abbr_month_names: ::Date::ABBR_MONTHNAMES,
      day_names: ::Date::DAYNAMES,
      abbr_day_names: ::Date::ABBR_DAYNAMES
    }
end

ActiveSupport::TimeZone.send :include, TimeZoneExt
