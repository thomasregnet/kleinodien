require 'rails_helper'
require "shared_examples_for_disambiguations"

RSpec.describe PodcastSerial, type: :model do
  context "without season" do
    before(:each) do
      @podcast_serial = FactoryGirl.create(:podcast_serial)
    end

    it "is valid with valid attributes" do
      expect(@podcast_serial).to be_valid
    end
  end
end
