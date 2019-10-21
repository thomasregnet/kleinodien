require 'rails_helper'

RSpec.describe Description, type: :model do
  context 'with exact one content' do
    before(:each) do
      DatabaseCleaner.start
      @description = FactoryBot.build(:artist_credit_description)
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
end
