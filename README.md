# Total Payment

Calculates the total payment corresponding to the hours worked based on the day of the week and time of day.

## Getting Started

A company offers their employees the flexibility to work the hours they want. 
They will pay for the hours worked based on the day of the week and time of day, 
according to the following table:

Monday - Friday

00:01 - 09:00 25 USD

09:01 - 18:00 15 USD

18:01 - 00:00 20 USD

Saturday and Sunday

00:01 - 09:00 30 USD

09:01 - 18:00 20 USD

18:01 - 00:00 25 USD

The goal of this application is to calculate the total that the company has to pay an employee, 
based on the hours they worked and the times during which they worked. 
The following abbreviations are used for entering data:

MO: Monday

TU: Tuesday

WE: Wednesday

TH: Thursday

FR: Friday

SA: Saturday

SU: Sunday

#### Input 

One (or more) file(s) with the name of an employee and the worked schedule, indicating the time and hours. 

Each line of the file is expected in the format:

```
<ID>=<DAY><HOUR1>-<HOUR2>[,<DAY><HOUR1>-<HOUR2>]...
```

where:

```
<ID> : identifies the worker, ex: RENE

<DAY>: abbreviation for day: MO, TU, WE, TH, FR, SA, SU 

<HOUR1>: hour in the range 00:00 to 23:59, in format h:m with 0 <= h <= 23 and  0 <= m <= 59

<HOUR2>: hour(see <HOUR1> for more) greater than or equals to <HOUR1>
```

Example:

```
RENE=MO10:00-12:00,TU10:00-12:00,TH01:00-03:00,SA14:00-18:00,SU20:00-21:00
ASTRID=MO10:00-12:00,TH12:00-14:00,SU20:00-21:00
```

#### Output 

Indicate how much the employee has to be paid

Example:

```
The amount to pay RENE is: 215.00 USD
The amount to pay ASTRID is: 85.00 USD 
```


### Prerequisites

For running the application Ruby version 2.5.1 at least

### Installing

Download or clone this repository

```
git clone https://github.com/kellsaro/total_payment_rb.git
```

Go to total_payment_rb folder an run

```
cd total_payment_rb
ruby total_payment.rb input.txt
```

You can especify multiple files with the information in right format

```
ruby total_payment.rb [path/to/file1.txt] [path/to/file2.txt] ...
```

If you don't especify a file a help will be shown

## Running the tests

Test are a work in progress, with improvement.

For running the test Minitest must be installed

```
gem install minitest
```

Then you can run tests that are under test folder

Example:

```
ruby test/controller/*.rb
```

## Built With

* [Ruby](https://www.ruby-lang.org/en/) - The programming language

## Authors

* **Maykell Sánchez Romero** - *Initial work* - [total_payment_rb](https://github.com/kellsaro/total_payment_rb.git)


## Acknowledgments

* Astrid Schneider from IOET, who propose the challenge

