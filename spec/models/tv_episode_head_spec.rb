require 'rails_helper'

RSpec.describe TvEpisodeHead, type: :model do
  before(:each) do
    @tv_episode_head = FactoryGirl.create(:tv_episode_head)
  end

  it "is valid with valid attributes" do
    expect(@tv_episode_head).to be_valid
  end
end
