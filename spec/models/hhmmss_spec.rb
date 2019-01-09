# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Hhmmss do
  describe '.milliseconds' do
    context 'with a valid hh:mm:ss string' do

      it 'returns the milliseconds' do
        expect(described_class.milliseconds('9:10:59'))
          .to eq(33059000)
        expect(described_class.milliseconds('0:00:00')).to eq(0)
      end
    end

    context 'with a invalid hh:mm:ss string' do
      it 'returns nil' do
        expect(described_class.milliseconds('Horst')).to be nil
        expect(described_class.milliseconds('1:60:55')).to be nil
        expect(described_class.milliseconds('1:01:60')).to be nil
      end
    end

    context 'with nil as mm:ss string' do
      it 'returns nil' do
        expect(described_class.milliseconds(nil)).to be nil
      end
    end
  end
end
