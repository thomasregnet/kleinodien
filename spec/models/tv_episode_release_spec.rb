# frozen_string_literal: true

require 'rails_helper'
require 'shared_examples_for_pieces'

RSpec.describe TvEpisodeRelease, type: :model do
  before do
    @tv_episode_release = FactoryBot.create(:tv_episode_release)
  end

  it 'is valid with valid attributes' do
    expect(@tv_episode_release).to be_valid
  end

  it_behaves_like 'a piece' do
    let(:piece) { @tv_episode_release }
  end
end
