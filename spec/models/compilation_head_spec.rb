require 'rails_helper'
require 'shared_examples_for_commentable'
require 'shared_examples_for_disambiguations'
require 'shared_examples_for_models_with_companies'
require 'shared_examples_for_models_with_countries'
require 'shared_examples_for_models_with_credits'
require 'shared_examples_for_models_with_labels'
require 'shared_examples_for_rateable_models'
require 'shared_examples_for_sources'
require 'shared_examples_for_tagable_models'

RSpec.describe CompilationHead, type: :model do
  before(:each) do
    @c_head = FactoryGirl.create(:compilation_head)
  end

  it 'is valid with valid attributes' do
    expect(@c_head).to be_valid
  end

  it "is allowed to use same 'name' and 'disambiguation' if type 'differs'" do
    @a_head = FactoryGirl.create(
      :album_head,
      title:          @c_head.title,
      disambiguation: @c_head.disambiguation
    )
    expect(@a_head).to be_valid

    disambiguation = 'something completly different'
    @a_head.disambiguation = disambiguation
    @c_head.disambiguation = disambiguation
    expect(@a_head).to be_valid
    expect(@c_head).to be_valid
    expect { @a_head.save! }.not_to raise_error
    expect { @c_head.save! }.not_to raise_error
  end

  it_behaves_like 'a commentable model' do
    before(:all) do
      DatabaseCleaner.start
      @commentable = FactoryGirl.create(:compilation_head)
    end

    let(:commentable) { @commentable }

    after(:all) { DatabaseCleaner.clean }
  end

  it_behaves_like 'a rateable model' do
    before(:all) do
      DatabaseCleaner.start
      @compilation_head = FactoryGirl.create(:compilation_head)
    end

    let(:rateable) { @compilation_head }

    after(:all) { DatabaseCleaner.clean }
  end

  it_behaves_like 'a tagable model' do
    before(:all) do
      DatabaseCleaner.start
      @tagable = FactoryGirl.create(:compilation_head)
    end

    let(:tagable) { @tagable }

    after(:all) { DatabaseCleaner.clean }
  end

  it_behaves_like 'a model with companies' do
    let(:factory) { :compilation_head_with_companies }
  end

  it_behaves_like 'a model with countries' do
    let(:factory) { :compilation_head_with_countries }
  end

  it_behaves_like 'a model with credits' do
    let(:factory) { :compilation_head_with_credits }
  end

  it_behaves_like 'a model with labels' do
    let(:factory) { :compilation_head_with_labels }
  end

  it_behaves_like 'a model with disambiguations' do
    let(:factory) { :compilation_head }
    let(:object) { @c_head }
    let(:naming) { 'title' }
  end

  it_behaves_like 'an object with a source' do
    let(:factory) { :compilation_head }
  end
end
