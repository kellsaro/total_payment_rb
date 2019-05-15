require_relative "../config/days_hours_configuration"

# Service for retrieving the configuration
# of days, range of hours and payment by hour.
class GetDaysHoursConfigurationService

  # Returns a Hash with the configuration
  # where each key is an Array of days symbols
  # and each value is a Hash where each key
  # is a RangeHours object and the value is a Numeric(Integer or Float)
  # representing the corresponding payment by hour.
  # Example:
  # {
  #   [:mo, :tu, :we, :th, :fr] => {00:00-00:00=>20, 00:01-09:00=>25, 09:01-18:00=>15, 18:01-23:59=>20},
  #   [:sa, :su]                => {00:00-00:00=>20, 00:01-09:00=>30, 09:01-18:00=>20, 18:01-23:59=>25}
  # }
  def exec()
    # In this implementation the configuration is
    # read from an object, but could be from another
    # source.
    # An advantage doing this way is that the
    # client doesn't have to worry about the underlaying
    # implementation. A change in the implementation
    # must not affect the client code while preserving
    # the format of the result.
    DaysHoursRangeConfiguration.get_configuration
  end
end
