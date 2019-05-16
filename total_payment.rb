require_relative "app/controller/total_payment_controller"

class TotalPayment
  def initialize()
    @total_payment_controller = TotalPaymentController.new
  end

  # Main application entry.
  # Reads arguments fron standard input.
  # All arguments are supossed to be files.
  # If file(s) is(are) given, reads each line and prints the result,
  # or error if there is a problem in the line.
  # If file is not given then help is printed.
  def main
    input_files = ARGV

    if !input_files.nil? && !input_files.empty?
      input_files.each { |file_name| process_file(file_name) }
    else
      printHelp
    end
  end

  private

  # Process file
  def process_file(file_name)
    puts "Processing file #{file_name}: "

    File.readlines(file_name).each_with_index do |line, i|
      begin
        puts "  #{process_worked_schedule(line)}"
      rescue => e1
        puts "  Problem with line #{i + 1} :"
        puts "    Content: #{line}"
        puts "    Error: #{e1}"
      end
    end
  rescue => e
    p e
  end

  # Process a line and prints the result.
  def process_worked_schedule(line)
    payment = @total_payment_controller.show(line)
    "The amount to pay #{payment.name} is: #{"%.2f" % payment.ammount} USD"
  end

  # Prints the help
  def printHelp
    File.readlines("./documents/help_en.txt").each do |line|
      print line
    end

    print "\n"
  end
end

if __FILE__ == $0
  app = TotalPayment.new
  app.main
end
