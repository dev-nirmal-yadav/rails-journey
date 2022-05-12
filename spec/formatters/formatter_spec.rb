# frozen_string_literal: true

require 'fileutils'
require './lib/formatters/formatter'

RSpec.describe Formatter do
  describe 'Instance Methods' do
    subject(:formatter) { described_class.new(:file) }

    describe '#build' do
      context 'when log directory exists' do
        context 'when file type is file' do
          after { formatter.build(operation: :w, data: 'Test', header: true) }

          it 'returns the formatted output' do
            expect(FileFormatter).to receive(:call).once
            expect(File.read('log/output.txt')).to include('********** Test **********')
          end
        end

        context 'when file type is other than file (here CSV)' do
          subject(:formatter) { described_class.new(:csv) }

          after { formatter.build(operation: :w, data: 'Test', header: true) }

          it 'does not return the formatted output' do
            expect(FileFormatter).to_not receive(:call)
          end
        end
      end

      context 'when log directory does not exists' do
        before do
          FileUtils.rm_rf('log')
          formatter.build(operation: :w, data: 'Test', header: true)
        end

        it 'creates log directory' do
          expect(Dir.exist?('log')).to be_truthy
        end
      end
    end
  end
end
