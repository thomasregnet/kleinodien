require 'rails_helper'
require 'shared_examples_for_commentable'
require 'shared_examples_for_entities_with_format_details'

RSpec.describe Repository, type: :model do
  it_behaves_like 'a commentable model' do
    before(:all) do
      DatabaseCleaner.start
      @compilation_release = FactoryGirl.create(:repository)
    end

    let(:commentable) { @compilation_release }

    after(:all) { DatabaseCleaner.clean }
  end  

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
      @repository.format = Format.find_by(name: 'CDr')
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
      @repository.format = Format.find_by(name: 'CDr')
      @repos_format_detail = RepositoryFormatDetail.new(
        #abbr:     'WAV',
        detail:   FormatDetail.find_by(name: 'WAV'),
        position: 0
      )
      @repository.format_details << @repos_format_detail
    end

    it_behaves_like 'an entity with format_details' do
      let(:entity) { @repository }
    end

    after(:all) do
      DatabaseCleaner.clean
    end
  end
end
