# frozen_string_literal: true

require './lib/parsers/file_parser'

# Helper for Specs.
module FixtureHelpers
  # Parses fixture files.
  # @param file_name [String] fixture's file name
  # @see (FileParser.build)
  # @return [Nokogiri::XML::Document, Hash]
  # @todo Handle me for different file extensions.
  def parsed_file(file_name = 'search.xml')
    FileParser.build("#{File.dirname(__dir__)}/fixtures/#{file_name}")
  end
end
