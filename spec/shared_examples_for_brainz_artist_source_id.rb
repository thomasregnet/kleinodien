RSpec.shared_examples 'a brainz artist source id' do
  def query_string_regex
    /\?inc=url-rels$/
  end

  it 'matches the query_string' do
    expect(source_id).to match(query_string_regex)
  end
end
