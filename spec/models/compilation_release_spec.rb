require 'rails_helper'
require 'shared_examples_for_models_with_countries'
require 'shared_examples_for_models_with_companies'
require 'shared_examples_for_models_with_credits'
require 'shared_examples_for_models_with_labels'
require 'shared_examples_for_incomplete_dates'
require 'shared_examples_for_sources'

RSpec.describe CompilationRelease, type: :model do
  context 'minimal CompilationRelease' do
    before(:each) do
      @c_release = FactoryGirl.create(:compilation_release)
    end

    it 'is valid with valid attributes' do
      expect(@c_release).to be_valid
    end

    it 'delegates title to its head' do
      expect(@c_release.title).to eq(@c_release.head.title)
    end

    it 'is not unique without a head' do
      @c_release.head = nil
      expect(@c_release).not_to be_valid
    end

    it 'is not unique without a type' do
      @c_release.type = nil
      expect(@c_release).not_to be_valid
    end

    it 'has a unique head' do
      clone = FactoryGirl.build(:compilation_release) do |c|
        c.head = @c_release.head
        c.type = @c_release.type
      end
      expect(clone).not_to be_valid
      expect { clone.save! validate: false }.to raise_error(
        ActiveRecord::RecordNotUnique)
    end

    it 'is valid with a duplicate head and a version' do
      clone = FactoryGirl.build(:compilation_release) do |c|
        c.head = @c_release.head
        c.type = @c_release.type
      end
      clone.version = 'other one'
      expect(clone).to be_valid
    end

    it 'is not valid with a duplicate head and duplicate version' do
      @c_release.version = 'version 1'
      @c_release.save!
      clone = FactoryGirl.build(:compilation_release) do |c|
        c.head = @c_release.head
        c.version = @c_release.version
      end
      expect(clone).not_to be_valid
      expect { clone.save! validate: false }.to raise_error(
        ActiveRecord::RecordNotUnique)
    end

    it 'is not valid with a duplicate head and duplicate upcase version' do
      @c_release.version = 'version 1'
      @c_release.save!
      clone = FactoryGirl.build(:compilation_release) do |c|
        c.head    = @c_release.head
        c.version = @c_release.version.upcase
      end
      expect(clone).not_to be_valid
      expect { clone.save! validate: false }.to raise_error(
        ActiveRecord::RecordNotUnique)
    end
  end

  context 'with identifiers' do
    before(:each) do
      @ci        = FactoryGirl.create(:compilation_identifier)
      @c_release = @ci.release
    end

    it 'is valid with valid attributes' do
      expect(@c_release).to be_valid
    end

    it 'has many identifiers' do
      expect(@c_release.identifiers.count).to eq(1)
    end
  end

  it_behaves_like 'a model with companies' do
    let(:factory) { :compilation_release_with_companies }
  end

  it_behaves_like 'a model with countries' do
    let(:factory) { :compilation_release_with_countries }
  end

  it_behaves_like 'a model with credits' do
    let(:factory) { :compilation_release_with_credits }
  end

  it_behaves_like 'a model with labels' do
    let(:factory) { :compilation_release_with_labels }
  end

  it_behaves_like 'a model with an IncompleteDate' do
    let(:factory) { :compilation_release }
    let(:date_naming) { 'date' }
  end

  it_behaves_like 'an object with a source' do
    let(:factory) { :compilation_release }
  end
end
