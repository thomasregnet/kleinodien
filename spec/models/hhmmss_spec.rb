# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Hhmmss do
  describe '.milliseconds' do
    context 'with "9:10:59" as argument' do
      it 'returns the milliseconds' do
        expect(described_class.milliseconds('9:10:59')).to eq(33_059_000)
      end
    end

    context 'with "0:00:00" as argument' do
      it 'returns 0' do
        expect(described_class.milliseconds('0:00:00')).to eq(0)
      end
    end

    context 'with nil as argument' do
      it 'returns nil' do
        expect(described_class.milliseconds(nil)).to be nil
      end
    end

    %w[Horst 1:60:55 1:01:60].each do |argument|
      context %(with the invalid argument "#{argument}") do
        it 'returns nil' do
          expect(described_class.milliseconds(argument)).to be_nil
        end
      end
    end
  end
end
