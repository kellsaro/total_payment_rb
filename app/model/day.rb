# Model for representing a day
class Day
  @@days = ["monday", "tuesday", "wednesday", "thursday", "friday", "saturday", "sunday"].freeze
  @@days_as_sym = @@days.each.map { |d| d[0, 2].to_sym }.freeze

  attr_reader :day

  # Allows the initialization of a new Day object
  # given a Day object, a day symbol or a day string
  # Params:
  #   d : Day | Symbol | String
  # Example:
  #   (irb)> d1 = Day.new("monday")
  #   => monday
  #   (irb)> d2 = Day.new(d1)
  #   => monday
  #   (irb)> d3 = Day.new(:mo)
  #   => monday
  #   (irb)> d4 = Day.new("monday")
  #   => monday
  def initialize(d)
    raise ArgumentError, "Invalid argument '#{d}'" if d.nil?

    if d.is_a? Day
      @day = d.day
    elsif d.is_a? Symbol
      raise ArgumentError, "Invalid argument '#{d}'" if not @@days_as_sym.include?(d)
      @day = @@days.find { |da| da.start_with?(d.to_s) }
    elsif d.is_a? String
      d = d.strip
      raise ArgumentError, "Invalid argument '#{d}'" if !@@days.include?(d.downcase)
      @day = @@days.find { |da| da.start_with?(d.downcase) }
    else
      raise ArgumentError, "Invalid argument '#{d}'"
    end
  end

  # Allows linguistic sugar for creating a day object
  # Example:
  #   (irb)> d1 = Day.monday
  #   => monday
  #   (irb)> d2 = Day.sunday
  #   => sunday
  def self.method_missing(name, *args)
    return Day.new(name.to_s) unless !@@days.include?(name.to_s)

    raise NoMethodError, "undefined method '#{name}' for Day:Class"
  end

  # Returns the Day after this
  # Example:
  #   (irb)> d1 = Day.monday
  #   => monday
  #   (irb)> d2 = d1.succ
  #   => tuesday
  #   (irb)> d3 = Day.new(:su)
  #   => sunday
  #   (irb)> d4 = d3.succ
  #   => monday
  def succ
    Day.new @@days[(@@days.find_index { |d| d == day } + 1) % 7]
  end

  def to_s
    day
  end

  def inspect
    to_s
  end

  def to_sym
    day[0, 2].to_sym
  end
end
