require_relative "../config/days_hours_configuration"

class GetMaxHoursConfigurationService
  def exec(day)
    DaysHoursRangeConfiguration.max_hours(day)
  end
end
