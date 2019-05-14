class Hour
  include Comparable
  attr_reader :hour, :minute

  def self.min
    Hour.new("00:00")
  end

  def self.max
    Hour.new("23:59")
  end

  def initialize(hm)
    hm = hm.to_s if hm.is_a? Hour

    hm_aux = hm.split(":")
    @hour = hm_aux[0].to_i % 24
    @minute = hm_aux[1].to_i % 60
  end

  def to_minutes
    (hour * 60) + minute
  end

  def clone
    Hour.new(self)
  end

  def succ
    m = (minute + 1) % 60
    h = (hour + ((minute + 1) / 60)) % 24
    Hour.new("%02d:%02d" % [h, m])
  end

  def <=>(other)
    return hour <=> other.hour if hour != other.hour
    minute <=> other.minute
  end

  def to_s
    "%02d:%02d" % [hour, minute]
  end

  def inspect
    to_s
  end
end
