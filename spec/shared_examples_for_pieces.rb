RSpec.shared_examples 'a piece' do
  it 'is not valid without head' do
    piece.head = nil
    expect(piece).not_to be_valid
  end

  it 'is valid when it comes' do
    expect(piece).to be_valid
  end
end
