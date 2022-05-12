# frozen_string_literal: true

require_relative 'connection'
require_relative 'interchange'

# Search Result details.
class SearchResult
  attr_reader :formatter,
              :id,
              :connections,
              :total_duration,
              :cheapest_fare,
              :interchanges

  def initialize(formatter)
    @formatter = formatter
  end

  def build_output(id)
    formatter.build(data: "Search Result ID: #{id}", sub_header: true)
  end

  def process_connections(connections_data)
    @connections = connections_data.map do |data|
      connection = Connection.new(formatter)
      connection.assign_attributes(data)
      connection.build_output
      connection.process_fares(data.search('Fare'))
      connection
    end
  end

  def assign_attributes(data)
    @id = data.search('ID').text
    @cheapest_fare = calculate_cheapest_fare
    @interchanges = calculate_connection_time_differences
    @total_duration = calculate_total_duration
  end

  def build_journey_summary
    formatter.build(data: 'Journey Summary', sub_header: true)
    formatter.build(data: "Train changes required: #{connections.count - 1}")
    formatter.build(data: 'Time the passenger has for each train change:')
    interchanges.each_with_index do |interchange, index|
      formatter.build(
        data: "\tChange #{index + 1}: #{interchange.format_interchange_duration}"
      )
    end
    formatter.build(data: "Total Journey Duration: #{TimeParser.in_hours(total_duration)}")
  end

  private

  def calculate_cheapest_fare
    return 0 unless connections

    connections.sum(&:minimum_fare)
  end

  def calculate_connection_time_differences
    train_interchanges = []
    return train_interchanges if connections.nil? || connections.count <= 1

    0.upto(connections.count - 2) do |index|
      train_interchanges << Interchange.new(connections[index], connections[index + 1])
    end
    train_interchanges
  end

  def calculate_total_duration
    return 0 unless connections

    connections.sum(&:duration) + interchanges.sum(&:duration)
  end
end
