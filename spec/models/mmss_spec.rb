# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Mmss do
  describe '.milliseconds' do
    context 'with a valid mm:ss string' do
      it 'returns the milliseconds' do
        expect(described_class.milliseconds('123:59')).to eq(7_439_000)
      end
    end

    context 'with "0:00" as value' do
      it 'returns 0' do
        expect(described_class.milliseconds('0:00')).to eq(0)
      end
    end

    context 'with a invalid mm:ss string' do
      it 'returns nil' do
        expect(described_class.milliseconds('Horst')).to be nil
      end
    end

    context 'with an uncomputeable string (1:60)' do
      it 'retruns nil' do
        expect(described_class.milliseconds('1:60')).to be nil
      end
    end

    context 'with nil as mm:ss string' do
      it 'returns nil' do
        expect(described_class.milliseconds(nil)).to be nil
      end
    end
  end
end
