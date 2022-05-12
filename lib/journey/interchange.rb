# frozen_string_literal: true

# Interchange details between two Connections.
class Interchange
  attr_reader :first_train, :second_train, :duration

  def initialize(first_connection, second_connection)
    @first_train = first_connection.train_name
    @second_train = second_connection.train_name
    @duration = TimeParser.diff_between(
      second_connection.departure_time, first_connection.arrival_time
    )
  end

  def format_interchange_duration
    "#{first_train} - #{second_train}: #{TimeParser.in_hours(duration)}"
  end
end
