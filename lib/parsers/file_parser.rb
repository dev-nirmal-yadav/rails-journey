# frozen_string_literal: true

require_relative 'file_parsers/xml_file_parser'

# Parses Files using Nokogiri.
class FileParser
  class << self
    def build(file_path)
      return { error: 'Invalid file' } unless valid_file?(file_path)

      file_extension = File.extname(file_path)
      # TODO: We can convert it to switch case statement when we start supporting other formats
      if file_extension.eql?('.xml')
        XmlFileParser.call(file_path)
      else
        { error: 'Unknown file format' }
      end
    end

    private

    def valid_file?(file_path)
      File.exist?(file_path) && File.file?(file_path)
    end
  end
end
