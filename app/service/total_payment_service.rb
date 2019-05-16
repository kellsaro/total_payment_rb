require_relative "../model/hours_range"
require_relative "get_days_hours_configuration_service"
require_relative "get_max_hours_configuration_service"
require "pry"

# Service for retrieving the payment
# for a worked schedule string line.
class TotalPaymentService
  def initialize
    @days_hours_cnf = GetDaysHoursConfigurationService.new.exec
  end

  # Returns the payment for the worked schedule string.
  # The payment is a float.
  def exec(worked_schedule)
    # The worked_scheduled is formated to a Hash
    # where each key is day symbol (:mo, ..)
    # and each value is an Array of string with range of hours
    group_by_day = worked_schedule.downcase
                                  .split(",")
                                  .map { |d| [d[0, 2].to_sym, d[2..-1].strip] }
                                  .group_by { |g| g[0] }

    group_by_day.each { |k, v| group_by_day[k] = v.flatten.delete_if { |v1| v1.is_a? Symbol } }

    # For each day and array of string of range of hours computes the payment
    group_by_day.sum do |day, schedules|

      # For each string with one range of hours computes the payment
      schedules.sum { |schedule| compute_ammount(day, schedule) }
    end
  end

  private

  # For a day and a string representing a range of hours computes
  # the corresponding payment
  def compute_ammount(day, schedule)
    range = HoursRange.new(schedule)

    max_hours = GetMaxHoursConfigurationService.new.exec(day)

    ranges = range.split_by_max_hours(max_hours)

    # returns an array where array[0] is the array of days and
    # array[1] is the hash with HoursRange mapping to quotation
    quotation_conf = @days_hours_cnf.find { |k, v| k.include?(day) }
    return 0 if quotation_conf.nil? || quotation_conf.empty?

    ammount = 0.0
    ranges.each do |r|
      quot = quotation_conf[1].find { |k, v| k.include?(r) }
      if !quot.nil? && !quot.empty?
        ammount += (quot[1] * r.to_minutes).to_f / 60
      end
    end

    ammount
  end
end
