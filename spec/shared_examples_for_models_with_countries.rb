RSpec.shared_examples 'a model with countries' do
  it 'has two countries set' do
    expect(candidate.countries.length).to eq(2)
  end
end
