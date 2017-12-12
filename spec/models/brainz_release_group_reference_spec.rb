require 'rails_helper'
require 'shared_examples_for_brainz_references'

RSpec.describe BrainzReleaseGroupReference do
  def test_code
    '4509c51e-b790-41aa-a2b3-e3bbf62cbf3f'
  end

  def test_key
    "musicbrainz.org/release-group/#{test_code}?#{test_query_string}"
  end

  def test_query_string
    'inc=artists+url-rels'
  end

  def test_uri
    'https://musicbrainz.org/ws/2/release-group/' \
    + "#{test_code}?#{test_query_string}"
  end

  it_behaves_like 'a MusicBrainz reference' do
    let(:code) { test_code }
    let(:key) { test_key }
    let(:uri) { test_uri }
  end
end
