RSpec.shared_examples 'a model with credits' do
  it 'has credits set' do
    expect(candidate.credits.length).to eq(2)
  end
end
