require 'rails_helper'

RSpec.describe Description, type: :model do
  context 'with exact one content' do
    before(:each) do
      DatabaseCleaner.start
      @description = FactoryGirl.build(:artist_credit_description)
    end

    it 'is valid with valid attributes' do
      expect(@description).to be_valid
    end

    it 'is not valid without text' do
      @description.text = nil
      expect(@description).not_to be_valid
    end

    it 'is not valid with blank text' do
      @description.text = ''
      expect(@description).not_to be_valid
    end

    after(:all) { DatabaseCleaner.clean }
  end
  context 'with more than one content' do
    before(:each) do
      DatabaseCleaner.start
      @description = FactoryGirl.create(:artist_credit_description)
    end

    factories = %i[
      artist compilation_head compilation_release country
      piece_head piece_release season serial station
    ]

    factories.each do |factory|
      it 'is not valid' do
        setter = factory.to_s + '='
        @description.send setter, FactoryGirl.create(factory)
        expect(@description).not_to be_valid
        expect { @description.save! validate: false }
          .to raise_error /exact_one_content_on_descriptions/
      end
    end

    after(:all) { DatabaseCleaner.clean }
  end
end
