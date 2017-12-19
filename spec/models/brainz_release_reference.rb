require 'rails_helper'
require 'shared_examples_for_references'
require 'shared_examples_for_brainz_references'

RSpec.describe BrainzReleaseReference do
  def test_code
    '4509c51e-b790-41aa-a2b3-e3bbf62cbf3f'
  end

  def test_key
    "musicbrainz.org/release/#{test_code}?#{test_query_string}"
  end

  def test_query_string
    'inc=artists+labels+recordings+release-groups'
  end

  def test_uri
    "https://musicbrainz.org/ws/2/release/#{test_code}?#{test_query_string}"
  end

  it_behaves_like 'a MusicBrainz reference' do
    let(:code) { test_code }
    let(:uri) { test_uri }
    let(:key) { test_key }
  end
end
