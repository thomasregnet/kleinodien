RSpec.shared_examples 'an entity with format_details' do
  it 'is valid' do
    expect(entity).to be_valid
  end

  it 'has set the format' do
    expect(entity.format).not_to be nil
  end

  it 'has set at least one FormatDetail' do
    expect(entity.format_details.length).to be >= 1
  end

  it 'can be saved to the database' do
    expect(entity.save).to be true
  end
end
