# frozen_string_literal: true

require_relative 'journey'

# Executer to execute the Process.
class Executer
  def self.call(file_path, file_type)
    processed_data = Journey.new(file_path, file_type).process
    return processed_data if processed_data.is_a?(String)

    File.read('log/output.txt')
  end
end

puts Executer.call("#{File.dirname(__dir__)}/#{ARGV.join('')}", :file) unless ENV['RACK_ENV']
