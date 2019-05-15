require_relative "payment_info"
require_relative "../service/total_payment_service"

class TotalPaymentController

  # Given a string line with id and worked schedule information
  # returns an PaymentInfo object with the id and total payment calculated.
  def total_payment(worked_schedule)
    name, schedule = worked_schedule.split("=")

    total_payment_service = TotalPaymentService.new
    ammount = total_payment_service.exec(schedule)

    PaymentInfo.new(name, ammount)
  end
end
