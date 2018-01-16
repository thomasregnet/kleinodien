require 'rails_helper'
require 'shared_examples_for_identifiers'

RSpec.describe ArtistIdentifier, type: :model do
  it_behaves_like 'an identifier' do
    let(:identifier) { FactoryBot.build(:artist_identifier) }
  end

  it 'is not valid without an Artist' do
    identifier = FactoryBot.build(:artist_identifier)
    identifier.artist = nil
    expect(identifier).not_to be_valid
  end
end
