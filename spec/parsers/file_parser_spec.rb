# frozen_string_literal: true

require './lib/parsers/file_parser'

RSpec.describe FileParser do
  describe 'Class Methods' do
    describe '.build' do
      context 'when file extension is xml' do
        context 'when file exists' do
          it 'parses the xml file' do
            file_path = 'spec/fixtures/search.xml'
            expect(described_class.build(file_path).name).to eq('document')
          end
        end

        context 'when the file does not exist' do
          it 'does not parses the file' do
            file_path = 'spec/fixtures/searches.xml'
            expect(described_class.build(file_path)).to have_key(:error)
          end
        end
      end

      context 'when file extension is other than xml' do
        it 'raises Error' do
          file_path = 'spec/fixtures/search.xmls'
          expect(described_class.build(file_path)).to have_key(:error)
        end
      end
    end
  end
end
