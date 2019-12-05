# frozen_string_literal: true

require 'rails_helper'
require 'test_data'

# Proxy for testing
class FakePersistBrainzReleaseTrackProxy
  def get(_)
    TestData.by_name(:brainz_recording_arise).blueprint
  end
end

RSpec.describe PersistBrainzReleaseTrack do
  context 'with valid arguments' do
    let(:args) do
      blueprint = TestData.by_name(:brainz_release_arise_jp_cd)
                          .blueprint.media[0].tracks[0]

      {
        blueprint:    blueprint,
        import_order: FactoryBot.create(:brainz_import_order),
        no:           3,
        proxy:        FakePersistBrainzReleaseTrackProxy.new,
        subset:       FactoryBot.create(:release_subset)
      }
    end

    it 'persists the track' do
      allow(PersistBrainzPiece).to receive(:call)
        .and_return(FactoryBot.build(:piece))
      expect(described_class.call(args)).to be_instance_of(ReleaseTrack)
    end
  end
end
