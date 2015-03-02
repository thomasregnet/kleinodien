require 'rails_helper'

RSpec.describe EpisodeHead, type: :model do
  before(:each) do
    @episode_head = FactoryGirl.create(:episode_head)
  end

  it "is valid with valid attributes" do
    expect(@episode_head).to be_valid
  end
end
