require "minitest/autorun"
require_relative "../../app/controller/total_payment_controller"
require_relative "../../app/controller/payment_info"

class TotalPaymentTest < Minitest::Test
  def test_payments_for_right_formated_hours
    controller = TotalPaymentController.new

    expected = PaymentInfo.new("RENE", 215.0)
    computed = controller.total_payment("RENE=MO10:00-12:00,TU10:00-12:00,TH01:00-03:00,SA14:00-18:00,SU20:00-21:00")
    assert_equal expected, computed

    expected = PaymentInfo.new("ASTRID", 85.0)
    computed = controller.total_payment("ASTRID=MO10:00-12:00,TH12:00-14:00,SU20:00-21:00")
    assert_equal expected, computed
  end
end
