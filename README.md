## Description ##

In the `search.xml` file is some XML output from a hypothetical rail
search API. The scenario is that we have performed a search from London
to Barcelona, and this is the output which we need to parse and display.

Unfortunately the real rail APIs are nowhere near this simple, but this
example provides more than enough complexity for the challenge!

Some definitions:

* There are 3 *search results*, representing different options for
  making the journey

* A search result has one or more *connections*, representing the
  individual train rides which make up the whole journey

* A *fare* represents the cost of travelling on this train in a given
  class of service (standard class, first class, etc). The currency is
  indicated in the XML, but it's always GBP (British Pounds) in our example.
  Please note that the decimal point (`.`) separates pence/cents from pounds,
  so `25.50` means 25 pounds and 50 pence.

## Task performed ##

I have wrote a program which will parse the XML file and output
information gleaned from the data.

The output contain the following information for each search
result:

* ID of search result
* Description of each connection, including start/finish and departure/arrival times and train names. (Times in the XML response are in the timezone local to the station and should remain that way in the output)
* Duration of each connection (represented as hours and minutes)
* How many train changes need to be made
* How much time the passenger has for each train change (represented as hours and minutes)
* Duration of the whole journey (represented as hours and minutes)
* Fare names / prices for each connection
* The cheapest search result
* The quickest search result

# Dependencies
* Ruby version : 3.0.1
* Bundler version : 2.2.15

# Prerequisites
1. Execute `ruby bin/setup` to install dependencies.

# Script to execute the program
1. `ruby lib/executer.rb 'task/search.xml'`

# Execute the specs
1. `rspec`

# Brief about program structure
1. I have created three classes/models (`SearchResult`, `Connection`, and `Fare`) based on the `search.xml` element structure.
2. Each class represents the details about the attributes specific to it.
3. I have divided the work-flow in three-part.
* FileParsers (which will fetch the details from `search.xml`)
* Journey classes (`Journey`, `SearchResult`, `Connection`, and `Fare`) to fetch appropriate data and process the details.
* Formatters (which will help us to format the output)
4. Other than that, I have also added the `Executer` class to automate the execution of the program.
5. I have also added class `TimeParser` to convert the time into different formats such as hours, date-time, or find out the difference between times in hours.
6. I have added a separate directory `Log` to save the output in different formats.
7. For now, as per requirement, I have only considered XMLs for parsing and `TXT` for formatting. however, I designed the structure so that I can easily add different parsers and Formatters in the future based on requirements.

# My Assumptions
While writing code, I set few assumptions as below,
1. I have calculated the cheapest fares among all the classes instead of only the Standard class(which might be the cheapest one).
2. For Arrival time and Departure time, I converted the format of times to display it in readable format however, I have not changed the time zone to UTC as mentioned in the description.

# Future Enhancements
1. Current implementation can be extended to add functionality when there are multiple currencies available in Fares and we can convert the other currencies to `GBP` for Rate calculation.
2. Currently I have created `XmlFileParser` to parse `XML` files, but we can add more parsers to parse the data when there are other file formats.
3. Currently I have created `FileFormatter` to format the output in `TXT` files, but we can add more formatters to organise the output in different file formats.

