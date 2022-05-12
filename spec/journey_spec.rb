# frozen_string_literal: true

require './lib/journey'

RSpec.describe Journey do
  describe '#Instance Methods' do
    subject(:journey) do
      described_class.new("#{File.dirname(__dir__)}/spec/fixtures/search.xml", :file)
    end

    describe '#process' do
      context 'when parsed data has errors' do
        context 'when error is for incorrect file format' do
          subject(:journey) do
            described_class.new("#{File.dirname(__dir__)}/spec/fixtures/search.xmls", :file)
          end

          it 'returns error message' do
            expect(journey.process).to include('Invalid file')
          end
        end

        context 'when error is for inexistance of file' do
          subject(:journey) do
            described_class.new("#{File.dirname(__dir__)}/spec/fixtures/searches.xml", :file)
          end

          it 'returns error message' do
            expect(journey.process).to include('Invalid file')
          end
        end
      end

      context 'when parsed data does not have errors' do
        before { journey.process }

        it 'processes parsed data and write journey details in output log' do
          expect(journey.parsed_data.name).to eq('document')
          expect(journey.search_results).to_not be_empty
          expect(File.read('log/output.txt')).to include('Result Summary')
        end
      end
    end
  end
end
