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

Input: the name of an employee and the schedule they worked, indicating the time and hours. 
This should be a .txt file with at least five sets of data. 
You can include the data from our two examples below.

Output: indicate how much the employee has to be paid

### Prerequisites

You need Ruby version 2.5.1 at least

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

If you don't especify a files a help will be shown

## Running the tests

Explain how to run the automated tests for this system

## Built With

* [Ruby](https://www.ruby-lang.org/en/) - The programming language

## Authors

* **Maykell Sánchez Romero** - *Initial work* - [total_payment_rb](https://github.com/kellsaro/total_payment_rb.git)


## Acknowledgments

* Astrid Schneider from IOET, who propose the challenge

