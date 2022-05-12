# frozen_string_literal: true

require_relative 'file_types/file_formatter'

# Formatter to display the results.
class Formatter
  attr_reader :file_type

  def initialize(file_type)
    @file_type = file_type
  end

  def build(args = {})
    # TODO: We can convert it to switch case statement when we start supporting other formats
    return { error: 'Invalid file type' } unless valid_file_type?

    create_log_directory
    FileFormatter.call(args)
  end

  def valid_file_type?
    file_type.eql?(:file)
  end

  private

  def create_log_directory
    return if Dir.exist?('log')

    Dir.mkdir('log')
  end
end
