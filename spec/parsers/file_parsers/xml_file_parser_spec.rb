# frozen_string_literal: true

require './lib/parsers/file_parsers/xml_file_parser'

RSpec.describe XmlFileParser do
  describe 'Class Methods' do
    describe '.call' do
      context 'when the file exists' do
        it 'parses the file' do
          xml_parser = described_class.call('spec/fixtures/search.xml')
          expect(xml_parser.name).to eq('document')
          expect(xml_parser.at('ID').text).to eq('F4S1DS')
          expect(xml_parser.search('Connection').count).to eq(7)
          expect(xml_parser.at('Start').text).to eq('London St Pancras International')
          expect(xml_parser.at('Finish').text).to eq('Paris Nord')
          expect(xml_parser.at('DepartureTime').text).to eq('2015-07-11T09:23:00+01:00')
          expect(xml_parser.at('ArrivalTime').text).to eq('2015-07-11T12:41:00+02:00')
          expect(xml_parser.at('TrainName').text).to eq('Eurostar')
          expect(xml_parser.search('Fare').count).to eq(14)
          expect(xml_parser.at('Fare').at('Name').text).to eq('Standard Class')
          expect(xml_parser.at('Price').at('Currency').text).to eq('GBP')
          expect(xml_parser.at('Price').at('Value').text).to eq('79.00')
        end
      end

      context 'when the file does not exist' do
        it 'does not parses the file' do
          xml_parser = described_class.call('spec/fixtures/searches.xml')
          expect(xml_parser).to have_key(:error)
        end
      end
    end
  end
end
