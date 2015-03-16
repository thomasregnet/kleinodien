require 'rails_helper'

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

    it "rectifies the date and sets the right date-mask" do
      idate = IncompleteDate.new(2015)
      @piece_release.date = idate
      expect(@piece_release.date.to_s).to eq('2015-01-01')
      expect(@piece_release.date.mask).to eq(4)
      
      @piece_release.date = IncompleteDate.new('2015')
      expect(@piece_release.date.to_s).to eq('2015-01-01')
      expect(@piece_release.date.mask).to eq(4)

      @piece_release.date = IncompleteDate.new('2015-03')
      expect(@piece_release.date.to_s).to eq('2015-03-01')
      expect(@piece_release.date.mask).to eq(6)

      @piece_release.date = IncompleteDate.new('2015-03-13')
      expect(@piece_release.date.to_s).to eq('2015-03-13')
      expect(@piece_release.date.mask).to eq(7)
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
