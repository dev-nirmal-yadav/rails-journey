# frozen_string_literal: true

require './lib/parsers/time_parser'

RSpec.describe TimeParser do
  describe 'Class Methods' do
    describe '.diff_between' do
      it 'converts the seconds to `00 hours 00 minutes` format' do
        start_time = '2015-07-11T13:56:00+02:00'
        end_time = '2015-07-11T12:41:00+02:00'
        expect(described_class.diff_between(start_time, end_time)).to eq(4500.0)
      end
    end

    describe '.in_hours' do
      it 'converts the seconds to `00 hours 00 minutes` format' do
        expect(described_class.in_hours(8280)).to eq('02 hours 18 minutes')
      end
    end

    describe '.in_datetime' do
      it 'converts the datetime to `dd/mm/yyyy 00 hours 00 minutes AM/PM time_zone` format' do
        expect(
          described_class.in_datetime('2015-07-11T09:23:00+01:00')
        ).to eq('11/07/2015 09:23AM +0100')
      end
    end
  end
end
