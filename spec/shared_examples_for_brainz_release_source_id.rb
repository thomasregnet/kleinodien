RSpec.shared_examples 'a brainz release source id' do
  def prefix_regex
    %r{^https://musicbrainz.org/ws/2/release/}
  end

  def query_string_regex
    /\?inc=artists\+labels\+recordings\+release-groups$/
  end

  it 'contains the prefix' do
    expect(source_id).to match(prefix_regex)
  end

  it 'matches the query_string' do
    expect(source_id).to match(query_string_regex)
  end
end
