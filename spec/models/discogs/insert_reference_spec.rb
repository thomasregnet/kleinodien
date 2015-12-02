require 'rails_helper'

RSpec.describe Discogs::InsertReference, type: :model do
  #pending "add some examples to (or delete) #{__FILE__}"
  context 'compilation_head' do
    before(:all) do
      DatabaseCleaner.start
      @album_head = FactoryGirl.create(:album_head)
    end

    it 'sets the reference' do
      Discogs::InsertReference.perform(123, @album_head, ChReference)
      expect(@album_head.reference.identifier).to eq('123')
      expect(@album_head.reference.supplier.name).to eq('Discogs')
    end

    after(:all) { DatabaseCleaner.clean }
  end

  context 'compilation_release' do
    before(:all) do
      DatabaseCleaner.start
      @album_release = FactoryGirl.create(:album_release)
    end

    it 'sets the reference' do
      Discogs::InsertReference.perform('abc', @album_release, CrReference)
      expect(@album_release.reference.identifier).to eq('abc')
      expect(@album_release.reference.supplier.name).to eq('Discogs')
    end

    after(:all) { DatabaseCleaner.clean }
  end
end
