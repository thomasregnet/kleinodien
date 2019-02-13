# frozen_string_literal: true

require 'rails_helper'
require 'test_data'

# Proxy for testing
class FakePersistBrainzHeapTrackProxy
  def get(_)
    TestData.by_name(:brainz_recording_arise).blueprint
  end
end

RSpec.describe PersistBrainzHeapTrack do
  context 'with valid arguments' do
    blueprint = TestData.by_name(:brainz_release_arise_jp_cd)
                        .blueprint.media[0].track_list.track[0]

    args = {
      blueprint: blueprint,
      no:        3,
      proxy:     FakePersistBrainzHeapTrackProxy.new,
      subset:    FactoryBot.create(:heap_subset)
    }

    it 'persists the track' do
      allow(PersistBrainzPiece).to receive(:call)
        .and_return(FactoryBot.build(:piece))
      expect(described_class.call(args)).to be_instance_of(HeapTrack)
    end
  end
end
