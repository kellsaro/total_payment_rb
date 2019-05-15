require_relative "days_hours_configurator"

# Class for configure the days, hours range and payment by hour.
class DaysHoursRangeConfiguration < DaysHoursConfigurator
  # Block for the configuration
  # For days consider the abbreviations mo, tu, we, th, fr, sa, su
  # The syntax for configure are:
  #   c.<day> = <Hash>
  #      the configuration only applies to one <day>
  #   c.<day1>2<day2> = <Hash>
  #      the configuration applies to all days in the closed range <day1>..<day2>
  #   c.<day1>_<day2>[_<day3>] = <Hash>
  #      the configuration applies to each day, one by one
  # where:
  #   day, day2, dayN are one of the abbreviations
  #   Hash is a mapping between hours ranges and payment
  configure do |c|
    # Monday - Friday
    # 00:01 - 09:00 25 USD
    # 09:01 - 18:00 15 USD
    # 18:01 - 00:00 20 USD
    c.mo2fr = {
      "00:00-00:00" => 20,
      "00:01-09:00" => 25,
      "09:01-18:00" => 15,
      "18:01-23:59" => 20,
    }

    # Saturday and Sunday
    # 00:01 - 09:00 30 USD
    # 09:01 - 18:00 20 USD
    # 18:01 - 00:00 25 USD
    c.sa_su = {
      "00:00-00:00" => 25,
      "00:01-09:00" => 30,
      "09:01-18:00" => 20,
      "18:01-23:59" => 25,
    }
  end
end
