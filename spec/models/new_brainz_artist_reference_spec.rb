require 'rails_helper'
require 'shared_examples_for_new_references'

RSpec.describe NewBrainzArtistReference do
  it_behaves_like 'a new reference' do
    let(:code) { '4509c51e-b790-41aa-a2b3-e3bbf62cbf3f' }
    let(:uri) do
      'https://musicbrainz.org/ws/2/artist/' \
      + '4509c51e-b790-41aa-a2b3-e3bbf62cbf3f?inc=url-rels'
    end
    let(:key) do
      'musicbrainz.org/artist/4509c51e-b790-41aa-a2b3-e3bbf62cbf3f?inc=url-rels'
    end
  end
end
