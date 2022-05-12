# frozen_string_literal: true

require './lib/formatters/file_types/file_formatter'

RSpec.describe FileFormatter do
  describe 'Class Methods' do
    describe '.call' do
      before { FileFormatter.call(operation: :w, data: 'Test', header: true) }

      it 'returns the formatted output' do
        expect(File.read('log/output.txt')).to include("********** Test **********\n")
      end
    end
  end
end
