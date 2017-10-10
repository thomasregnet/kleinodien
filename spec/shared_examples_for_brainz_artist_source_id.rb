RSpec.shared_examples 'a brainz artist source id' do
  def prefix_regex
    %r{^ws/2/artist/}
  end

  def query_string_regex
    /\?inc=currently\+unknown$/
  end

  it 'contains the prefix' do
    expect(source_id).to match(prefix_regex)
  end

  it 'matches the query_string' do
    expect(source_id).to match(query_string_regex)
  end
end
