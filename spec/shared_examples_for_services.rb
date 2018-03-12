RSpec.shared_examples 'a service' do
  it 'responds to .call' do
    expect(described_class).to respond_to(:call)
  end
end
