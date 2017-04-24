require 'rails_helper'
require 'shared_examples_for_commentable'
require 'shared_examples_for_models_with_countries'
require 'shared_examples_for_models_with_companies'
require 'shared_examples_for_models_with_credits'
require 'shared_examples_for_models_with_labels'
require 'shared_examples_for_incomplete_dates'
require 'shared_examples_for_rateable_models'
require 'shared_examples_for_sources'
require 'shared_examples_for_tagable_models'

RSpec.describe CompilationRelease, type: :model do
  specify '#comments' do
    expect(subject).to respond_to(:comments)
  end

  it_behaves_like 'a commentable model' do
    before(:all) do
      DatabaseCleaner.start
      @compilation_release = FactoryGirl.create(:compilation_release)
    end

    let(:commentable) { @compilation_release }

    after(:all) { DatabaseCleaner.clean }
  end

  it_behaves_like 'a rateable model' do
    before(:all) do
      DatabaseCleaner.start
      @compilation_release = FactoryGirl.create(:compilation_release)
    end

    let(:rateable) { @compilation_release }

    after(:all) { DatabaseCleaner.clean }
  end

  it_behaves_like 'a tagable model' do
    before(:all) do
      DatabaseCleaner.start
      @tagable = FactoryGirl.create(:compilation_release)
    end

    let(:tagable) { @tagable }

    after(:all) { DatabaseCleaner.clean }
  end

  context 'with identifiers' do
    before(:each) do
      @identifier = FactoryGirl.create(:cr_identifier)
      @c_release = @identifier.identified
    end

    specify '#identifiers' do
      expect(@c_release.identifiers.count).to eq 1
    end
  end

  context 'with product_numbers' do
    before(:each) do
      @product_number = FactoryGirl.create(:product_number)
      @c_release      = @product_number.release
    end

    it 'is valid with valid attributes' do
      expect(@c_release).to be_valid
    end

    it 'has many product_numbers' do
      expect(@c_release.product_numbers.count).to eq(1)
    end
  end

  it_behaves_like 'a model with companies' do
    let(:candidate) { FactoryGirl.create(:compilation_release_with_companies) }
  end

  it_behaves_like 'a model with countries' do
    let(:candidate) { FactoryGirl.create(:compilation_release_with_countries) }
  end

  it_behaves_like 'a model with credits' do
    let(:candidate) { FactoryGirl.create(:compilation_release_with_credits) }
  end

  it_behaves_like 'a model with labels' do
    let(:factory) { :compilation_release_with_labels }
  end

  it_behaves_like 'a model with an IncompleteDate' do
    let(:candidate) { FactoryGirl.create(:compilation_release) }
    let(:date_naming) { 'date' }
  end

  it_behaves_like 'an object with a source' do
    let(:factory) { :compilation_release }
  end
end
