require_relative "../model/hours_range"
require_relative "get_days_hours_configuration_service"
require_relative "get_max_hours_configuration_service"
require "pry"

class TotalPaymentService
  def initialize
    @days_hours_cnf = GetDaysHoursConfigurationService.new.exec
  end

  def exec(worked_schedule)
    group_by_day = worked_schedule.downcase
                                  .split(",")
                                  .map { |d| [d[0, 2].to_sym, d[2..-1].strip] }
                                  .group_by { |g| g[0] }

    group_by_day.each { |k, v| group_by_day[k] = v.flatten.delete_if { |v1| v1.is_a? Symbol } }

    p = group_by_day.sum do |day, schedules|
      schedules.sum { |schedule| compute_ammount(day, schedule) }
    end

    p.round(2)
  end

  private

  def compute_ammount(day, schedule)
    range = HoursRange.new(schedule)

    max_hours = GetMaxHoursConfigurationService.new.exec(day)

    ranges = range.split_by_max_hours(max_hours)

    cotization_conf = @days_hours_cnf.find { |k, v| k.include?(day) }
    return 0 if cotization_conf.nil? || cotization_conf.empty?

    ammount = 0.0
    ranges.each do |r|
      cot = cotization_conf[1].find { |k, v| k.include?(r) }
      if !cot.nil? && !cot.empty?
        ammount += (cot[1] * r.to_minutes).to_f / 60
      end
    end

    ammount
  end
end
