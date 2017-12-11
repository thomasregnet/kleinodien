require 'rails_helper'
require 'shared_examples_for_new_references'

RSpec.describe BrainzArtistReference do
  def test_code
    '4509c51e-b790-41aa-a2b3-e3bbf62cbf3f'
  end

  def test_key
    "musicbrainz.org/artist/#{test_code}?#{test_query_string}"
  end

  def test_query_string
    'inc=url-rels'
  end

  def test_uri
    "https://musicbrainz.org/ws/2/artist/#{test_code}?#{test_query_string}"
  end

  it_behaves_like 'a new reference' do
    let(:code) { '4509c51e-b790-41aa-a2b3-e3bbf62cbf3f' }
  end

  it_behaves_like 'a reference initialized from_code' do
    let(:code) { test_code }
    let(:uri) { test_uri }
    let(:key) { test_key }
  end

  it_behaves_like 'a reference initialized from_key' do
    let(:code) { test_code }
    let(:uri) { test_uri }
    let(:key) { test_key }
  end

  it_behaves_like 'a reference initialized from_uri' do
    let(:code) { test_code }
    let(:uri) { test_uri }
    let(:key) { test_key }
  end

  it_behaves_like 'a hash key' do
    let(:code) { test_code }
    let(:uri) { test_uri }
    let(:key) { test_key }
  end
end
