# frozen_string_literal: true

require 'rails_helper'
require 'test_data'

RSpec.describe PersistBrainzHeapTrack do
  context 'with valid arguments' do
    args = {
      subset: FactoryBot.create(:heap_subset)
    }
    it 'persists the track' do
      expect(described_class.call(args)).to be true
    end
  end
end
