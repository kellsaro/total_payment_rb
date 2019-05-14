require_relative "days_hours_configurator"

class DaysHoursRangeConfiguration < DaysHoursConfigurator
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
