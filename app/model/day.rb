class Day
  @@days = ["monday", "tuesday", "wednesday", "thursday", "friday", "saturday", "sunday"].freeze
  @@days_as_sym = @@days.each.map { |d| d[0, 2].to_sym }.freeze

  attr_reader :day

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

  def self.all
    @@days
  end

  def self.all_as_sym
    @@days_as_sym
  end

  def self.method_missing(name, *args)
    return Day.new(name.to_s) unless !@@days.include?(name.to_s)

    raise NoMethodError, "undefined method '#{name}' for Day:Class"
  end

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
