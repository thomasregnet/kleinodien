# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CalculateBrainzNap do
  describe '#last' do
    it 'is less than now' do
      expect(described_class.call(error: false)).to be(0)
    end
  end
end
