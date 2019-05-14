class PaymentInfo
  attr_reader :name, :ammount

  def initialize(name, ammount)
    @name = name
    @ammount = ammount
  end
end
