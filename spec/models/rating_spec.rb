require 'rails_helper'

RSpec.describe Rating, type: :model do
  context 'with or without a content' do
    before(:each) do
      @rating = FactoryGirl.build(:artist_credit_rating)
    end

    it 'is valid' do
      expect(@rating).to be_valid
    end

    it 'is not valid without an user' do
      @rating.user = nil
      expect(@rating).not_to be_valid
    end

    it 'is not valid without a content' do
      @rating.artist_credit = nil
      expect(@rating).not_to be_valid
    end
  end

  context 'with more than one content' do
    before(:each) do
      @rating = FactoryGirl.build(:artist_credit_rating)
    end

    factories = [
      :artist, :compilation_head, :compilation_release,
      :piece_head, :piece_release, :season, :serial, :station
    ]

    factories.each do |factory|
      setter = factory.to_s + '='
      it "is not valid when artist_credit and #{factory} are set" do
        @rating.send setter, FactoryGirl.create(factory)
        expect(@rating).not_to be_valid
      end
    end
  end
end
