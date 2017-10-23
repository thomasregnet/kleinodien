require 'rails_helper'
require 'brainz_test_helper'

RSpec.describe Import::BrainzRelease, type: :model do
  before(:each) do
    DatabaseCleaner.start
    @xml = BrainzTestHelper.get_xml(
      :release,
      '28e723f2-1c0a-38a0-8109-038cca05ffca'
    )
  end

  # it 'returns an AlbumHead' do
  #   album_head = Import::BrainzRelease.perform(@xml)
  #   expect(album_head).to be_instance_of AlbumHead
  #   expect(album_head.type).to eq 'AlbumHead'
  #   expect(album_head).not_to be_new_record
  #   expect(album_head.title).to eq 'Butchered at Birth'
  #   expect(album_head.identifiers.first.value)
  #     .to eq '846e5976-9b9b-3e4f-a96b-f15c2585b725'
  # end
  it 'returns an AlbumRelease' do
    album_release = Import::BrainzRelease.perform(@xml)
    expect(album_release).to be_instance_of AlbumRelease
  end

  after(:each) do
    DatabaseCleaner.clean
  end
end
