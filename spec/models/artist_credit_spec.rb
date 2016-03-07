require 'rails_helper'

RSpec.describe ArtistCredit, type: :model do
  context 'without data_supplier' do
    before(:each) do
      @artist_credit = FactoryGirl.create(:artist_credit)
    end

    it { is_expected.to respond_to(:artists) }

    it 'is valid with valid attributes' do
      expect(@artist_credit).to be_valid
    end

    # TODO: clone may not be valid because it has no paricipants
    it 'must have a unique name' do
      clone = ArtistCredit.new(name: @artist_credit.name)
      expect(clone).not_to be_valid
    end

    it 'is not valid without a participant' do
      @artist_credit = FactoryGirl.build(:artist_credit)
      @artist_credit.participants = []
      expect(@artist_credit).not_to be_valid
    end

    it 'raises an error when it sets its participants to null' do
      expect { @artist_credit.participants = [] }
        .to raise_error(/null value in column "artist_credit_id"/)
    end
  end

  context 'with data_supplier' do
    before(:all) do
      DatabaseCleaner.start
      @artist_credit = FactoryGirl.create(
        :artist_credit_with_data_supplier
      )
    end

    it 'is valid' do
      expect(@artist_credit).to be_valid
    end

    it 'must have an unique name' do
      clone = ArtistCredit.new(name: @artist_credit.name)
      expect(clone).not_to be_valid
    end

    it 'must not have an unique name when the DataSupplier differs' do
      clone = ArtistCredit.new(
        data_supplier: FactoryGirl.create(:data_supplier),
        participants:  [@artist_credit.participants.first]
      )
      expect(clone).to be_valid
    end

    after(:all) { DatabaseCleaner.clean }
  end
end
