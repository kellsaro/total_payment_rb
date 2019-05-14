require_relative "../config/days_hours_configuration"

class GetDaysHoursConfigurationService
  def exec()
    DaysHoursRangeConfiguration.get_configuration
  end
end
