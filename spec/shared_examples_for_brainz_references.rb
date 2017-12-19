require 'shared_examples_for_references'

RSpec.shared_examples 'a MusicBrainz reference' do
  let(:category) { :brainz }

  it_behaves_like 'a new reference'
  it_behaves_like 'a reference initialized from_code'
  it_behaves_like 'a reference initialized from_key'
  it_behaves_like 'a reference initialized from_uri'
  it_behaves_like 'a hash key'
end
