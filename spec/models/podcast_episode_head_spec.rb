require 'rails_helper'
require 'shared_examples_for_disambiguations'

RSpec.describe PodcastEpisodeHead, type: :model do
  before(:each) do
    @pe_head = FactoryGirl.create(:podcast_episode_head)
  end

  it "is valid with valid attributes" do
    expect(@pe_head).to be_valid
  end

  it_behaves_like "a model with disambiguations" do
    let(:factory) { :podcast_episode_head }
    let(:object) { @pe_head }
    let(:naming) { 'title' }
  end
end
