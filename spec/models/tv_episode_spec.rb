require 'rails_helper'

RSpec.describe TvEpisode, type: :model do
  before(:each) do
    @tv_episode = FactoryGirl.create(:tv_episode)
  end

  it "is valid with valid attributes" do
    expect(@tv_episode).to be_valid
  end
end
