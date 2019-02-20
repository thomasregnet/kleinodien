require 'rails_helper'

RSpec.shared_examples 'a rating with a wrong value' do
  it 'is not valid' do
    expect(rating).not_to be_valid
  end

  it 'raises an error if it is saved without being validated' do
    expect { rating.save! validate: false }
      .to raise_error(/ratings_value_between_0_and_10/)
  end
end

RSpec.describe Rating, type: :model do
  describe '#value' do
    before(:all) do
      DatabaseCleaner.start
      @bigger_rating = FactoryBot.build(:artist_credit_rating, value: -1)
      @lower_rating  = FactoryBot.build(:artist_credit_rating, value: 11)
    end

    context 'with a value bigger than 10' do
      it_behaves_like 'a rating with a wrong value' do
        let(:rating) { @bigger_rating }
      end
    end

    context 'with a value lower than 0' do
      it_behaves_like 'a rating with a wrong value' do
        let(:rating) { @lower_rating }
      end
    end

    after(:all) { DatabaseCleaner.clean }
  end

  context 'valid values' do
    (0..10).to_a.each do |value|
      it "is valid with #{value} as value" do
        @rating = FactoryBot.build(:artist_credit_rating, value: value)
        expect(@rating).to be_valid
      end
    end
  end

  context 'with or without a content' do
    before(:each) do
      @rating = FactoryBot.build(:artist_credit_rating)
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

  # context 'with more than one content' do
  #   before(:each) do
  #     @rating = FactoryBot.build(:artist_credit_rating)
  #   end

  #   factories = %i[
  #     artist compilation_head compilation_release
  #     piece_head piece season serial station
  #   ]

  #   factories.each do |factory|
  #     setter = factory.to_s + '='
  #     it "is not valid when artist_credit and #{factory} are set" do
  #       @rating.send setter, FactoryBot.create(factory)
  #       expect(@rating).not_to be_valid
  #       expect { @rating.save! validate: false }
  #         .to raise_error(/exact_one_content_on_ratings/)
  #     end
  #   end
  # end
end
