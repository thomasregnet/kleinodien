require 'rails_helper'

RSpec.describe Description, type: :model do
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

  describe 'with more than one content' do
    before(:each) do
      DatabaseCleaner.start
      @description = FactoryGirl.build(:artist_credit_description)
    end

    contents = [
      :artist, :compilation_head, :compilation_release, :country,
      :piece_head, :piece_release, :season, :serial, :station
    ]

    contents.each do |content|
      it 'is not valid' do
        setter = content.to_s + '='
        @description.send setter, FactoryGirl.create(content)
        expect(@description).not_to be_valid
      end
    end

    after(:all) { DatabaseCleaner.clean }
  end
end
