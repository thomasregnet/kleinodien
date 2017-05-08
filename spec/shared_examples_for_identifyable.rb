RSpec.shared_examples 'an identifyable model' do
  it 'responds to .identify' do
    expect(identifyable.class).to respond_to(:identify)
  end

  it 'identifies the object' do
    identifier  = identifyable.identifiers[0]
    source_name = identifier.source.name
    value       = identifier.value

    found = identifyable.class.identify(source_name, value)

    expect(found.id).to eq identifyable.id
  end

  it 'returns nil if the nothing can be identified' do
    found = identifyable.class.identify('unknown source', 'no such id')
    expect(found).to be_nil
  end
end
