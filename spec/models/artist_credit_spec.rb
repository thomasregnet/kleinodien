require 'rails_helper'

RSpec.describe ArtistCredit, type: :model do
  context 'without a Source' do
    context 'not saved to the database' do
      before(:each) do
        @artist_credit = FactoryGirl.build(:artist_credit)
      end

      it { is_expected.to respond_to(:artists) }

      it 'is valid with valid attributes' do
        expect(@artist_credit).to be_valid
      end

      it 'is not valid without a participant' do
        @artist_credit.participants = []
        expect(@artist_credit).not_to be_valid
      end
    end

    context 'saved to the database' do
      before(:each) do
        @artist_credit = FactoryGirl.create(:artist_credit)
      end
      it 'raises an error when it sets its participants to null' do
        expect { @artist_credit.participants = [] }
          .to raise_error(/null value in column "artist_credit_id"/)
      end

      it 'must have a unique name' do
        clone = ArtistCredit.new(participants: @artist_credit.participants)
        expect(clone).not_to be_valid
      end
    end
  end

  context 'with Source' do
    before(:all) do
      DatabaseCleaner.start
      @artist_credit = FactoryGirl.create(:artist_credit_with_source)
    end

    it 'is valid' do
      expect(@artist_credit).to be_valid
    end

    it 'must have an unique name' do
      clone = ArtistCredit.new(name: @artist_credit.name)
      expect(clone).not_to be_valid
    end

    it 'must not have an unique name when the Source differs' do
      clone = ArtistCredit.new(
        participants:  @artist_credit.participants,
        source:        FactoryGirl.create(:source)
      )
      expect { clone.save! }.not_to raise_error
    end

    after(:all) do
      DatabaseCleaner.clean
    end
  end
end
