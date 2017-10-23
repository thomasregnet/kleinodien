require 'rails_helper'
require 'shared_examples_for_brainz_artist_source_id'

RSpec.describe BrainzArtistId do
  describe '.source_id' do
    it_behaves_like 'a brainz artist source id' do
      let(:source_id) { BrainzArtistId.source_id(SecureRandom.uuid) }
    end
  end

  describe '#source_id' do
    it_behaves_like 'a brainz artist source id' do
      brainz_artist_id = BrainzArtistId.new(value: SecureRandom.uuid)
      let(:source_id) { brainz_artist_id.source_id }
    end
  end
end
