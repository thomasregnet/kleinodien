RSpec.shared_examples 'an identifyable model' do
  it 'responds to .identify' do
    expect(identifyable.class).to respond_to(:identify)
  end
end
