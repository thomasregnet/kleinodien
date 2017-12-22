require 'rails_helper'

RSpec.describe UriToReference do
  describe 'with a MusicBrainz artist uri' do
    let(:uri) do
      'https://musicbrainz.org/ws/2/artist/' \
      + 'd1346194-325a-4ea3-826f-e0c68ce38c5b' \
      + '?inc=url-rels'
    end

    it 'returns a BrainzArtistReference' do
      expect(described_class.perform(uri))
        .to be_instance_of(BrainzArtistReference)
    end
  end
end
