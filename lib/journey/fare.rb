# frozen_string_literal: true

# Fare details.
class Fare
  attr_reader :formatter, :name, :currency, :price

  def initialize(formatter)
    @formatter = formatter
  end

  def assign_attributes(data)
    @name = data.search('Name').text
    @currency = data.search('Currency').text
    @price = data.search('Value').text.to_f
  end

  def build_output
    formatter.build(data: "Fare: #{name}/#{currency} #{price}")
  end
end
