RSpec.shared_examples 'a piece' do
  it 'is valid when it comes' do
    expect(piece).to be_valid
  end
end
