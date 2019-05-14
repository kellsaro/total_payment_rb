require_relative "app/controller/total_payment_controller"

class TotalPayment
  def initialize()
    @total_payment_controller = TotalPaymentController.new
  end

  def main
    input_files = ARGV

    if !input_files.empty?
      input_files.each do |file_name|
        begin
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
      end
    else
      help = <<-eos
      NAME
              total_payment - computes the total payment for worked schedule information

      SYNOPSYS
              ruby total_payment.rb [FILE1] [FILE2] ...

      DESCRIPTION
              Computes the total payment for each line of the input file.
                The payments are calculated according to the configuration in app/config/days_hours_configuration.rb

                File format:

                  Each line of the file is expected in the format:

                    <ID>=<DAY><HOUR1>-<HOUR2>[,<DAY><HOUR1>-<HOUR2>]...

                  where:

                    <ID> : identifies the worker, ex: RENE

                    <DAY>: upcased first 2 letters of the day: MO, TU, WE, TH, FR, SA, SU 

                    <HOUR1>: hour in the range 00:00 to 23:59, in format h:m with 0 <= h <= 23 and  0 <= m <= 59
                  
                    <HOUR2>: hour(see <HOUR1> for more) greater than or equals to <HOUR1>

                Line examples:
                  RENE=MO10:00-12:00,TU10:00-12:00,TH01:00-03:00,SA14:00-18:00,SU20:00-21:00
                  ASTRID=MO10:00-12:00,TH12:00-14:00,SU20:00-21:00  

              With no file, prints this help.

      EXAMPLES
              Lets supose the following configuration:

                Monday - Friday:

                00:01 - 09:00 --> 25 USD
                09:01 - 18:00 --> 15 USD
                18:01 - 00:00 --> 20 USD

                Saturday and Sunday

                00:01 - 09:00 --> 30 USD
                09:01 - 18:00 --> 20 USD
                18:01 - 00:00 --> 25 USD

              input.txt file with lines:
                RENE=MO10:00-12:00,TU10:00-12:00,TH01:00-03:00,SA14:00-18:00,SU20:00-21:00
                ASTRID=MO10:00-12:00,TH12:00-14:00,SU20:00-21:00

              Then run in the command line:

                ruby total_payment.rb input.txt

              OUTPUT:

              Processing file input.txt: 
                The amount to pay RENE is: 215.00 USD
                The amount to pay ASTRID is: 85.00 USD     

      AUTHOR
              Maykell Sánchez Romero (kellsaro@gmail.com)
      eos

      puts help
    end
  end

  def process_worked_schedule(line)
    payment = @total_payment_controller.total_payment(line)
    "The amount to pay #{payment.name} is: #{"%.2f" % payment.ammount} USD"
  end
end

if __FILE__ == $0
  app = TotalPayment.new
  app.main
end
