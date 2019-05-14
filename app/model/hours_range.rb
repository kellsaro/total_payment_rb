require_relative "hour"

class HoursRange
  attr :composed, :min, :max

  def self.subranges(string_range)
    _min, _max = string_range.split("-")
    hmin = Hour.new(_min)
    hmax = Hour.new(_max)

    if hmax < hmin
      return [HoursRange.new("#{hmin}-23:59"), HoursRange.new("00:00-#{hmax}")]
    end

    [HoursRange.new(range)]
  end

  def initialize(sr)
    sr = sr.to_s if sr.is_a? HoursRange

    _min, _max = sr.split("-")
    @min = Hour.new(_min)
    @max = Hour.new(_max)

    if @max < @min
      raise ArgumentError, "Max hour in range must be greater than or equal to min hour"
    end
  end

  def split_by_max_hours(sh_array)
    return self if sh_array.nil? || sh_array.empty?

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

  def include?(shr)
    return false if shr.nil?

    if shr.is_a?(Hour) || (shr.is_a?(String) && !shr.include?("-"))
      return include_hour?(shr)
    end

    include_range?(shr)
  end

  # True if the hour is in the range. False if the hour is nil or isn't in the range
  # Parameters:
  #   sh: Hour instance or String formated like h:m where 0 <= h <= 23 and 0 <= m <= 59
  def include_hour?(sh)
    return false if sh.nil?
    sh = Hour.new(sh) if sh.is_a? String

    min <= sh && sh <= max
  end

  def include_range?(sr)
    return false if sr.nil?
    sr = HoursRange.new(sr) if sr.is_a? String

    min <= sr.min && sr.max <= max
  end

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
