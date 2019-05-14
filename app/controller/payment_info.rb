class PaymentInfo
  attr_reader :name, :ammount

  def initialize(name, ammount)
    @name = name
    @ammount = ammount
  end

  def ==(other)
    return false if other.nil? || !other.is_a?(PaymentInfo)

    name == other.name && ammount == other.ammount
  end
end
