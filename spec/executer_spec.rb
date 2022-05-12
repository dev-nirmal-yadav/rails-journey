# frozen_string_literal: true

require './lib/executer'

RSpec.describe Executer do
  describe 'Class Methods' do
    describe '.call' do
      after { described_class.call("#{File.dirname(__dir__)}/spec/fixtures/search.xml", :file) }

      it 'executes the process to process the parsed data' do
        expect_any_instance_of(Journey).to receive(:process).once
      end

      context 'when execution failed' do
        it 'shows error raised' do
          expect(
            described_class.call("#{File.dirname(__dir__)}/spec/fixtures/search.xml", :files)
          ).to eq('Invalid file type')
        end
      end

      context 'when execution response is success' do
        it 'reads the output file' do
          expect(
            described_class.call("#{File.dirname(__dir__)}/spec/fixtures/search.xml", :file)
          ).to eq(File.read('log/output.txt'))
        end
      end
    end
  end
end
