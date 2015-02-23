require 'rails_helper'
require 'shared_examples_for_disambiguations'

RSpec.describe TvEpisodeHead, type: :model do
  before(:each) do
    @tv_episode_head = FactoryGirl.create(:tv_episode_head)
  end

  it "is valid with valid attributes" do
    expect(@tv_episode_head).to be_valid
  end

  it_behaves_like "a model with disambiguations" do
    let(:factory) { :tv_episode_head }
    let(:object) { @tv_episode_head }
    let(:naming) { 'title' }
  end
end
