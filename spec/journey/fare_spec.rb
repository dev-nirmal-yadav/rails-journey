# frozen_string_literal: true

require './lib/journey/fare'

RSpec.describe Fare do
  subject(:fare) { described_class.new(Formatter.new(:file)) }

  describe 'Instance Methods' do
    describe '#assign_attributes' do
      context 'when the parsed data has required fare details' do
        it 'assigns name, currency and price values' do
          fare.assign_attributes(parsed_file.at('Fare'))
          expect(fare.name).to eq('Standard Class')
          expect(fare.currency).to eq('GBP')
          expect(fare.price).to eq(79)
        end
      end

      context 'when parsed data does not have required fare details' do
        it 'does not assigns name, currency and price values' do
          fare.assign_attributes(parsed_file.search('Faress'))
          expect(fare.name).to be_empty
          expect(fare.currency).to be_empty
          expect(fare.price).to be_zero
        end
      end
    end

    describe '#build_output' do
      before do
        fare.assign_attributes(parsed_file.at('Fare'))
        fare.build_output
      end

      it 'writes output in the File' do
        expect(File.read('log/output.txt')).to include('Fare: Standard Class/GBP 79.0')
      end
    end
  end
end
