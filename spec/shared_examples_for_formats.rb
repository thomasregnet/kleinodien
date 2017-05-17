RSpec.shared_examples 'a format' do
  it 'is valid with valid parameters' do
    expect(format).to be_valid
  end

  it 'is not valid without a abbr' do
    format.abbr = nil
    expect(format).not_to be_valid
  end

  it 'is not valid without a name' do
    format.name = nil
    expect(format).not_to be_valid
  end

  it 'has a unique name' do
    clone = format.dup
    clone.abbr = 'some abbr'
    format.save!
    expect(clone).not_to be_valid
  end
end
