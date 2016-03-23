require 'rails_helper'
require 'shared_examples_for_pieces'

RSpec.describe PodcastEpisodeRelease, type: :model do
  before(:each) do
    @pe_release = FactoryGirl.create(:podcast_episode_release)
  end

  it 'is valid with valid attributes' do
    expect(@pe_release).to be_valid
  end

  it_behaves_like 'a piece' do
    let(:piece) { @pe_release }
  end
end
