require_relative "../config/days_hours_configuration"

# Service for retrieving the max hours
# of the ranges of hours configured for
# a day.
class GetMaxHoursConfigurationService
  # Returns a sorted array of hours and those hours
  # are de max hour of each range configured
  # for the day.
  # The array also includes "00:00" and "23:59"
  # hours by default.
  # The array is asc sorted
  # Example:
  #   [00:00, 09:00, 18:00, 23:59]
  def exec(day)
    DaysHoursRangeConfiguration.max_hours(day)
  end
end
