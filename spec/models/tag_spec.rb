require 'rails_helper'

RSpec.describe Tag, type: :model do
  context 'without associations' do
    before(:each) do
      DatabaseCleaner.start
      @tag = FactoryBot.create(:tag)
    end

    it 'is valid' do
      expect(@tag).to be_valid
    end

    it 'is not valid without a name' do
      @tag.name = nil
      expect(@tag).not_to be_valid
    end

    it 'must have an unique name' do
      clone = FactoryBot.build(:tag, name: @tag.name)
      expect(clone).not_to be_valid
    end

    after(:each) { DatabaseCleaner.clean }
  end
end
