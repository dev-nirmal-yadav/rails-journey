# frozen_string_literal: true

require './lib/journey/connection'

RSpec.describe Connection do
  describe 'Instance Methods' do
    subject(:connection) { described_class.new(Formatter.new(:file)) }

    describe '#assign_attributes' do
      context 'when the parsed data has required connection details' do
        before { connection.assign_attributes(parsed_file.at('Connection')) }

        it 'assigns attributes of Connection' do
          expect(connection.train_name).to eq('Eurostar')
          expect(connection.start).to eq('London St Pancras International')
          expect(connection.finish).to eq('Paris Nord')
          expect(connection.departure_time).to eq('2015-07-11T09:23:00+01:00')
          expect(connection.arrival_time).to eq('2015-07-11T12:41:00+02:00')
          expect(connection.duration).to eq(8280)
        end
      end

      context 'when parsed data does not have required connection details' do
        before { connection.assign_attributes(parsed_file.search('COnnection')) }

        it 'initializes connection with attributes as blank' do
          expect(connection.train_name).to be_empty
          expect(connection.start).to be_empty
          expect(connection.finish).to be_empty
          expect(connection.departure_time).to be_empty
          expect(connection.arrival_time).to be_empty
          expect(connection.duration).to be_zero
        end
      end
    end

    describe '#build_output' do
      before do
        connection.assign_attributes(parsed_file.at('Connection'))
        connection.build_output
      end

      it 'writes output in the File' do
        expect(File.read('log/output.txt')).to include('Finish Station: Paris Nord')
      end
    end

    describe '#process_fares' do
      context 'when fares data is present in the parsed data' do
        before do
          connection.assign_attributes(parsed_file.at('Connection'))
          connection.process_fares(parsed_file.search('Fare'))
        end
        it 'returns Fares with the assigned attributes' do
          expect(connection.fares).to_not be_empty
        end
      end

      context 'when fares data is absent in the parsed data' do
        before do
          connection.assign_attributes(parsed_file.at('Connection'))
          connection.process_fares(parsed_file.search('Faress'))
        end
        it 'returns empty' do
          expect(connection.fares).to be_empty
        end
      end
    end

    describe '#minimum_fare' do
      context 'when fares are present in connection' do
        before do
          connection.assign_attributes(parsed_file.at('Connection'))
          connection.process_fares(parsed_file.at('Connection').search('Fare'))
        end

        it 'returns minimum price from Fares' do
          expect(connection.minimum_fare).to eq(79)
        end
      end

      context 'when fares are not present in connection' do
        before do
          connection.assign_attributes(parsed_file.at('Connection'))
          allow_any_instance_of(Connection).to receive(:fares).and_return([])
        end

        it 'returns zero' do
          expect(connection.minimum_fare).to be_nil
        end
      end
    end
  end
end
