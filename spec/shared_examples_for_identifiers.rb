RSpec.shared_examples 'an identifier' do
  it 'is valid with valid parameters' do
    expect(identifier).to be_valid
  end

  it 'is not valid without an identified' do
    identifier.identified = nil
    expect(identifier).not_to be_valid
  end

  it 'is not valid without a source' do
    identifier.source = nil
    expect(identifier).not_to be_valid
  end

  it 'is not valid without a value' do
    identifier.value = nil
    expect(identifier).not_to be_valid
  end

  it 'is not valid with a blank value' do
    identifier.value = ''
    expect(identifier).not_to be_valid
  end
end
