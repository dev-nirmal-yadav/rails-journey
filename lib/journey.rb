# frozen_string_literal: true

require_relative 'parsers/file_parser'
require_relative 'parsers/time_parser'
require_relative 'formatters/formatter'
require_relative 'journey/search_result'

# Interacts with FileParser, SearchResult, and Formatter classes to parse and read the XML file.
class Journey
  attr_reader :parsed_data, :formatter, :search_results

  def initialize(file_path, file_type)
    @parsed_data = FileParser.build(file_path)
    @formatter = Formatter.new(file_type)
  end

  def process
    return processing_error if processing_error?

    build_header_text
    process_search_results
    build_output
  end

  private

  def processing_error?
    (parsed_data.is_a?(Hash) && parsed_data.key?(:error)) || !formatter.valid_file_type?
  end

  def processing_error
    parsed_data[:error] || formatter.build[:error]
  end

  def build_header_text
    formatter.build(operation: :w, data: 'SearchResult', header: true)
  end

  def process_search_results
    return [] if parsed_data.is_a?(Hash)

    @search_results = parsed_data.search('SearchResult').map do |result|
      search_result = SearchResult.new(formatter)
      search_result.build_output(result.search('ID').text)
      search_result.process_connections(result.search('Connection'))
      search_result.assign_attributes(result)
      search_result.build_journey_summary
      search_result
    end
  end

  def build_output
    formatter.build(data: 'Result Summary', sub_header: true)
    formatter.build(data: "Cheapest Search Result: #{cheapest_search_result}")
    formatter.build(data: "Quickest Search Result: #{quickest_search_result}")
    formatter.build(footer: true)
  end

  def cheapest_search_result
    return if search_results.empty?

    min_cheapest_fare = search_results.map(&:cheapest_fare).min
    search_result = search_results.find { |result| result.cheapest_fare == min_cheapest_fare }
    "#{search_result&.id} - GBP #{min_cheapest_fare}"
  end

  def quickest_search_result
    return if search_results.empty?

    min_total_duration = search_results.map(&:total_duration).min
    search_result = search_results.find { |result| result.total_duration == min_total_duration }
    "#{search_result.id} - #{TimeParser.in_hours(min_total_duration)}"
  end
end
