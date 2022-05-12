# frozen_string_literal: true

require 'nokogiri'

# Parses XML Files using Nokogiri.
class XmlFileParser
  def self.call(file_path)
    Nokogiri::XML.parse(File.read(file_path))
  rescue StandardError => e
    { error: e.message }
  end
end
