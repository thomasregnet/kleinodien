require 'rails_helper'

RSpec.describe PieceRelease, type: :model do
  context "without tracks" do
    before(:each) do
      @piece_release = FactoryGirl.create(:piece_release)
    end

    it "is valid with valid attributes" do
      expect(@piece_release).to be_valid
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
end
