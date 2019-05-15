# Value object for tranfering the
# calculated information.
class PaymentInfo
  attr_reader :name, :ammount

  def initialize(name, ammount)
    @name = name
    @ammount = ammount
  end

  # Comparison method for determining
  # when two objects of this class are
  # equals while are not the same
  def ==(other)
    return false if other.nil? || !other.is_a?(PaymentInfo)

    name == other.name && ammount == other.ammount
  end
end
