# frozen_string_literal: true

require 'time'
require './lib/parsers/time_parser'
require_relative 'fare'

# Connection details.
class Connection
  attr_reader :formatter,
              :train_name,
              :start,
              :finish,
              :departure_time,
              :arrival_time,
              :duration,
              :fares

  def initialize(formatter)
    @formatter = formatter
  end

  def assign_attributes(data)
    @train_name = data.search('TrainName').text
    @start = data.search('Start').text
    @finish = data.search('Finish').text
    @departure_time = data.search('DepartureTime').text
    @arrival_time = data.search('ArrivalTime').text
    @duration = calculate_duration
  end

  def build_output
    formatter.build(data: "Train Name: #{train_name}", sub_header: true)
    formatter.build(data: "Start Station: #{start}")
    formatter.build(data: "Finish Station: #{finish}")
    formatter.build(data: "Departure Time: #{TimeParser.in_datetime(departure_time)}")
    formatter.build(data: "Arrival Time: #{TimeParser.in_datetime(arrival_time)}")
    formatter.build(data: "Duration: #{TimeParser.in_hours(duration)}")
  end

  def process_fares(fares_data)
    @fares = fares_data.map do |fare_data|
      fare = Fare.new(formatter)
      fare.assign_attributes(fare_data)
      fare.build_output
      fare
    end
  end

  def minimum_fare
    fares.map(&:price).min
  end

  private

  def calculate_duration
    return 0 if arrival_time.empty? || departure_time.empty?

    Time.parse(arrival_time) - Time.parse(departure_time)
  end
end
