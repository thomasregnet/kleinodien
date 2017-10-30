require 'rails_helper'
require 'shared_examples_for_identifyable'

RSpec.describe AlbumRelease, type: :model do
  it_behaves_like 'an identifyable model' do
    let(:identifyable) { FactoryGirl.create(:album_release_with_identifiers) }
  end

  it 'belongs_to :artist_credit' do
    album_release = FactoryGirl.create(:album_release)
    album_release.artist_credit = FactoryGirl.create(:artist_credit)
    expect { album_release.save! }.not_to raise_error

    association = AlbumRelease.reflect_on_association(:artist_credit)
    expect(association.macro).to eq(:belongs_to)
  end
end
