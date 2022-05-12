# frozen_string_literal: true

require './lib/journey/connection'
require './lib/journey/interchange'

RSpec.describe Interchange do
  describe 'Instance Methods' do
    let(:first_connection) { Connection.new(Formatter.new(:file)) }

    let(:second_connection) { Connection.new(Formatter.new(:file)) }

    subject(:interchange) { described_class.new(first_connection, second_connection) }

    before do
      first_connection.assign_attributes(parsed_file.at('Connection'))
      second_connection.assign_attributes(parsed_file.search('Connection').last)
    end

    describe '#new' do
      it 'assigns the Interchange attributes' do
        expect(interchange.first_train).to eq('Eurostar')
        expect(interchange.second_train).to eq('AVE Class 100')
        expect(interchange.duration).to eq(76_560.0)
      end
    end

    describe '#format_interchange_duration' do
      it 'returns interchange duration with train names' do
        expect(interchange.format_interchange_duration).to eq(
          'Eurostar - AVE Class 100: 21 hours 16 minutes'
        )
      end
    end
  end
end
