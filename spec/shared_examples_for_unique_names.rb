# frozen_string_literal: true

RSpec.shared_examples 'an entity with an unique name' do
  it 'is valid with valid attributes' do
    expect(candidate).to be_valid
  end

  it 'is not valid without a name' do
    candidate.name = nil
    expect(candidate).not_to be_valid
  end

  it 'is not valid with a blank name' do
    candidate.name = ''
    expect(candidate).not_to be_valid
  end

  it 'is not valid with a duplicate name' do
    expect(candidate).to validate_uniqueness_of(:name).case_insensitive
  end
end
