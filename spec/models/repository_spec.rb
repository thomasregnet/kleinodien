require 'rails_helper'

RSpec.describe Repository, type: :model do
  context 'when live is simple' do
    before(:each) do
      DatabaseCleaner.start
      @repository = FactoryGirl.build(:repository)
    end

    it 'is valid with valid attributes' do
      expect(@repository).to be_valid
    end

    it 'is not valid without a name' do
      @repository.name = nil
      expect(@repository).not_to be_valid
    end

    it 'is not valid without a user' do
      @repository.user = nil
      expect(@repository).not_to be_valid
    end

    after(:all) do
      DatabaseCleaner.clean
    end
  end

  context 'with a format' do
    before(:all) do
      DatabaseCleaner.start
      @repository = FactoryGirl.build(:repository)
      @repository.format = Format.find('CDr')
    end

    it 'has that format set' do
      expect(@repository.format.name).to eq 'CDr'
    end

    after(:all) do
      DatabaseCleaner.clean
    end
  end

  context 'with format details' do
    before(:all) do
      DatabaseCleaner.start
      @repository = FactoryGirl.build(:repository)
      @repository.format = Format.find('CDr')
      @repos_format_detail = RepositoryFormatDetail.new(
        abbr:     'WAV',
        position: 0
      )
      @repository.format_details << @repos_format_detail
    end

    it 'works' do
      expect(@repository.save).to be true
    end

    after(:all) do
      DatabaseCleaner.clean
    end
  end
end
