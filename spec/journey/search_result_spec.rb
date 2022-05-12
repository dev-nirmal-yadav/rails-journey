# frozen_string_literal: true

require './lib/journey/search_result'

RSpec.describe SearchResult do
  describe 'Instance Methods' do
    subject(:search_result) { described_class.new(Formatter.new(:file)) }

    describe '#build_output' do
      before do
        search_result.process_connections(parsed_file.search('Connection'))
        search_result.assign_attributes(parsed_file.at('SearchResult'))
        search_result.build_output(parsed_file.search('ID').text)
      end

      it 'writes output in the File' do
        expect(File.read('log/output.txt')).to include('Search Result ID: F4S1DSL2FSF4D42GVV')
      end
    end

    describe '#process_connections' do
      context 'when connections data is present in the parsed data' do
        before do
          search_result.process_connections(parsed_file.search('Connection'))
          search_result.assign_attributes(parsed_file.at('SearchResult'))
        end
        it 'returns Connections with the assigned attributes' do
          expect(search_result.connections).to_not be_empty
        end
      end

      context 'when connections data is absent in the parsed data' do
        before do
          search_result.process_connections(parsed_file.search('COnnection'))
          search_result.assign_attributes(parsed_file.at('SearchResult'))
        end
        it 'returns empty' do
          expect(search_result.connections).to be_empty
        end
      end
    end

    describe '#assign_attributes' do
      context 'when the parsed data has required search result details' do
        before do
          parsed_search_result = parsed_file.at('SearchResult')
          search_result.process_connections(parsed_search_result.search('Connection'))
          search_result.assign_attributes(parsed_search_result)
        end

        it 'assigns search result attributes' do
          expect(search_result.id).to eq('F4S1DS')
          expect(search_result.connections).to_not be_empty
          expect(search_result.total_duration).to eq(35_640.0)
          expect(search_result.cheapest_fare).to eq(129)
        end
      end

      context 'when the parsed data does not have required search result details' do
        before { search_result.assign_attributes(parsed_file.search('Searchresult')) }

        it 'assigns search result attributes' do
          expect(search_result.id).to be_empty
          expect(search_result.connections).to be_nil
          expect(search_result.total_duration).to be_zero
          expect(search_result.cheapest_fare).to be_zero
        end
      end
    end

    describe '#build_journey_summary' do
      before do
        parsed_search_result = parsed_file.at('SearchResult')
        search_result.process_connections(parsed_search_result.search('Connection'))
        search_result.assign_attributes(parsed_search_result)
        search_result.build_journey_summary
      end

      it 'writes output in the File' do
        expect(File.read('log/output.txt')).to include('Journey Summary')
      end
    end
  end
end
