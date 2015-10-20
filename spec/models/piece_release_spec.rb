require 'rails_helper'
require 'shared_examples_for_models_with_credits'
require 'shared_examples_for_models_with_countries'
require 'shared_examples_for_models_with_labels'
require 'shared_examples_for_incomplete_dates'

RSpec.describe PieceRelease, type: :model do
  context "without tracks" do
    before(:each) do
      @piece_release = FactoryGirl.create(:piece_release)
    end

    it "is valid with valid attributes" do
      expect(@piece_release).to be_valid
    end

    it "delegates title to its head" do
      expect(@piece_release.title).to eq(@piece_release.head.title)
    end
  end

  context "with tracks" do
    before(:each) do
      @piece_release = FactoryGirl.create(:piece_release_with_tracks)
    end

    it "has some tracks" do
      expect(@piece_release.tracks.count).to be > 0
    end
  end
  
  it_behaves_like "a model with countries" do
    let(:factory) { :piece_release_with_countries }
  end
  
  it_behaves_like "a model with credits" do
    let(:factory) { :piece_release_with_credits }
  end

  it_behaves_like "a model with labels" do
    let(:factory) { :piece_release_with_labels }
  end  

  it_behaves_like "a model with an IncompleteDate" do
    let(:factory) { :piece_release }
    let(:date_naming) { 'date' }
  end
end
