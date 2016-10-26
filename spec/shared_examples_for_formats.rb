RSpec.shared_examples "a format" do
  it 'has the name set' do
    expect(format.name).to eq name
  end

  it 'has the abbr set' do
    expect(format.abbr).to eq abbr
  end

  it 'has the format set' do
      expect(format.format.name).to eq name
  end

  it 'is not valid without a name' do
    format = klass.new
    expect(format).not_to be_valid
  end
end
