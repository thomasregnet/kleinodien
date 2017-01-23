require 'rails_helper'

RSpec.describe Rating, type: :model do
  describe '#value' do
    it 'is not valid with a value smaller than 0' do
      @rating = FactoryGirl.build(:artist_credit_rating, value: -1)
      expect(@rating).not_to be_valid
    end

    it 'is not valid with a value greater than 10' do
      @rating = FactoryGirl.build(:artist_credit_rating, value: 11)
      expect(@rating).not_to be_valid
    end

    context 'valid values' do
      (0..10).to_a.each do |value|
        it "is valid with #{value} as value" do
          @rating = FactoryGirl.build(:artist_credit_rating, value: value)
          expect(@rating).to be_valid
        end
      end
    end
  end

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
