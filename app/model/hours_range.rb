require_relative "hour"

# Represents a range of hours where the min hour is always
# lesser than or equals to the max hour.
# The range is inclusive, closed, meaning that both the min hour and
# the max hour belongs to the range.
# The min hour possible is Hour.min and the max hour possible is Hour.max
class HoursRange
  attr :composed, :min, :max

  # Returns an array of one or two ranges
  # Params:
  #   string_range : String in the format <Hour1>-<Hour2>
  #                  See the class Hour for more abour the hour format.
  # If hour2 < hour1 then two ranges are returned in the array:
  #   - the first one is the range hour1-23:59
  #   - the second one is the range 00:00-hour2
  # If hour1 <= hour2 then the array will contain only the range hour1-hour2
  # Examples:
  #   pry(main)> HoursRange.subranges("05:04-23:08")
  #   => [05:04-23:08]
  #   pry(main)> HoursRange.subranges("23:08-05:04")
  #   => [23:08-23:59, 00:00-05:04]
  def self.subranges(string_range)
    _min, _max = string_range.split("-")
    hmin = Hour.new(_min)
    hmax = Hour.new(_max)

    if hmax < hmin
      return [HoursRange.new("#{hmin}-23:59"), HoursRange.new("00:00-#{hmax}")]
    end

    [HoursRange.new(string_range)]
  end

  # Initialize a RangeHour object
  # Params:
  #   string_range : String in the format <Hour1>-<Hour2>
  #                  See the class Hour for more abour the hour format.
  # hour1 must be lesser than or equals to hour2.
  # If hour2 < hour1 then an ArgumentError is raised
  # Examples:
  #   pry(main)> HoursRange.new("05:04-23:08")
  #   => 05:04-23:08
  #   pry(main)> HoursRange.new("23:08-05:04")
  #   ArgumentError: Max hour in range must be greater than or equal to min hour
  #   from app/model/hours_range.rb:47:in `initialize'
  def initialize(string_range)
    string_range = string_range.to_s if string_range.is_a? HoursRange

    _min, _max = string_range.split("-")
    @min = Hour.new(_min)
    @max = Hour.new(_max)

    if @max < @min
      raise ArgumentError, "Max hour in range must be greater than or equal to min hour"
    end
  end

  # Returns an array with ranges of hour results
  # of splitting this range by the hours in sh_array
  # Params:
  #   sh_array : Array with hours (as string or as Hour objects)
  # Example:
  #   pry(main)> HoursRange.new("05:04-23:08").split_by_max_hours(["00:00", "09:00", "18:00", "23:59"])
  #   => [05:04-09:00, 09:01-18:00, 18:01-23:08]
  def split_by_max_hours(sh_array)
    return [self] if sh_array.nil? || sh_array.empty?

    sh_array = sh_array.map { |sh| hour = Hour.new(sh) }.sort

    range = clone()
    ranges = []

    sh_array.each do |hour|
      if !range.nil? && range.include?(hour)
        r1 = HoursRange.new("#{range.min}-#{hour}")
        ranges << r1

        if Hour.max != hour && hour.succ < range.max
          range = HoursRange.new("#{hour.succ}-#{range.max}")
        else
          range = nil
        end
      end
    end

    ranges << range unless range.nil?

    ranges
  end

  # Returns true if the given hour or hours range is included
  # in this.
  # Params:
  #   shr : String | Hour | Range
  #         If shr is a String then must follow the rules for representing
  #         an hour or an hours ranges.
  # Examples:
  #   pry(main)> HoursRange.new("05:04-23:08").include?("05:00")
  #   => false
  #   pry(main)> HoursRange.new("05:04-23:08").include?("05:04")
  #   => true
  #   pry(main)> HoursRange.new("05:04-23:08").include?("05:00-08:00")
  #   => false
  #   pry(main)> HoursRange.new("05:04-23:08").include?("07:07-08:00")
  #   => true
  def include?(shr)
    return false if shr.nil?

    if shr.is_a?(Hour) || (shr.is_a?(String) && !shr.include?("-"))
      return include_hour?(shr)
    end

    include_range?(shr)
  end

  # True if the hour is in this range. False if the hour is nil or isn't in the range
  # Params:
  #   sh: Hour | String formated like h:m where 0 <= h <= 23 and 0 <= m <= 59
  def include_hour?(sh)
    return false if sh.nil?
    sh = Hour.new(sh) if sh.is_a? String

    min <= sh && sh <= max
  end

  # True if the hours range is in this range. False if the hours range is nil or isn't in this range
  # Params:
  #   sh: HoursRange | String formated like h:m where 0 <= h <= 23 and 0 <= m <= 59
  def include_range?(sr)
    return false if sr.nil?
    sr = HoursRange.new(sr) if sr.is_a? String

    min <= sr.min && sr.max <= max
  end

  # Returns the ammount of minutes between the min hour and the max hour of this range
  def to_minutes
    max.to_minutes - min.to_minutes
  end

  def clone
    HoursRange.new(self)
  end

  def to_s
    "#{min}-#{max}"
  end

  def inspect
    to_s
  end
end
