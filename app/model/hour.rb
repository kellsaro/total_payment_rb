# Model for representing an hour
class Hour
  include Comparable
  attr_reader :hour, :minute

  # Returns the min hour object 00:00
  def self.min
    Hour.new("00:00")
  end

  # Returns the max hour object 23:59
  def self.max
    Hour.new("23:59")
  end

  # Initialize an hour object from a right formatted string.
  # Params:
  #   hm : String in format "h:m" where 0 <= h <= 23 and 0 <= m <= 59
  #        If h or m are out of range module 24 and 60 will be used, respectively.
  # Example:
  #   (irb)> h1 = Hour.new("01:45")
  #   => 01:45
  def initialize(hm)
    hm = hm.to_s if hm.is_a? Hour

    hm_aux = hm.split(":")
    @hour = hm_aux[0].to_i % 24
    @minute = hm_aux[1].to_i % 60
  end

  # Returns the minutes conversion of this hour
  # Example:
  #   (irb)> h = Hour.new("02:30")
  #   => 02:30
  #   (irb)> h.to_minutes
  #   => 150
  def to_minutes
    (hour * 60) + minute
  end

  def clone
    Hour.new(self)
  end

  # Returns the hour representing a minute after this
  # Example:
  #   (irb)> h = Hour.new("02:45")
  #   => 02:30
  #   (irb)> h.succ
  #   => 02:31
  #   (irb)> h = Hour.new("23:59")
  #   => 23:59
  #   (irb)> h.succ
  #   => 00:00
  def succ
    m = (minute + 1) % 60
    h = (hour + ((minute + 1) / 60)) % 24
    Hour.new("%02d:%02d" % [h, m])
  end

  # Comparison operator implementation.
  # Besides Hour.new("23:59").succ is Hour.new("00:00")
  # the hour 00:00 will always be lesser than 23:59.
  # The comparison is based on the to_minutes representation
  def <=>(other)
    return nil if other.nil? || !other.is_a?(Hour)
    to_minutes <=> other.to_minutes
  end

  def to_s
    "%02d:%02d" % [hour, minute]
  end

  def inspect
    to_s
  end
end
