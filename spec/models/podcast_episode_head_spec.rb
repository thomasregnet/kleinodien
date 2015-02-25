require 'rails_helper'

RSpec.describe PodcastEpisodeHead, type: :model do
  before(:each) do
    @pe_head = FactoryGirl.create(:podcast_episode_head)
  end

  it "is valid with valid attributes" do
    expect(@pe_head).to be_valid
  end
end
