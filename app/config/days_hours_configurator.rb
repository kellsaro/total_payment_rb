require_relative "../model/hour"
require_relative "../model/day"
require_relative "../model/hours_range"

class DaysHoursConfigurator
  attr_reader :conf

  def initialize()
    @conf = {}
  end

  def self.get_configuration
    @@conf.conf.clone.freeze
  end

  def self.max_hours(day)
    h = self.get_configuration
    schedule = h.collect { |k, v| v.keys if k.include?(day.to_sym) }
                .compact
                .flatten

    max_hours = [Hour.min, Hour.max]
    schedule.each do |r|
      range = HoursRange.new(r)
      max_hours << range.max if !max_hours.include?(range.max)
    end

    max_hours.sort
  end

  def self.configure(&block)
    @@conf = DaysHoursConfigurator.new
    yield @@conf
    @@conf.conf.freeze
  end

  def method_missing(name, *args)
    name = name.to_s
    raise NoMethodError, "undefined method '#{name}' for #{self}" if !name.end_with?("=")

    name = name[0..-2]
    days_in_range = []

    name.split("_").each do |day|
      case day.length
      when 2
        if "[]" == day
          @@conf.conf[args[0]] = args[1]
        else
          begin
            d = Day.new(day.to_sym)
            days_in_range << d.to_sym
          rescue => exception
            raise NoMethodError, "undefined method '#{name}=' for #{self}"
          end
        end
      when 5
        begin
          init_day = Day.new(day[0, 2].to_sym)
          final_day = Day.new(day[3..-1].to_sym)

          loop do
            if init_day.to_s == final_day.to_s
              days_in_range << init_day.to_sym
              break
            end

            days_in_range << init_day.to_sym
            init_day = init_day.succ
          end
        rescue => exception
          raise NoMethodError, "undefined method '#{name}=' for #{self}"
        end
      else
        raise NoMethodError, "undefined method '#{name}=' for #{self}"
      end
    end

    @@conf[days_in_range] = args[0].transform_keys { |k| HoursRange.new(k) } unless days_in_range.empty?
  end
end
