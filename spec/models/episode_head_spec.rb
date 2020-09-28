# frozen_string_literal: true

require 'rails_helper'

RSpec.describe EpisodeHead, type: :model do
  let(:episode_head) { FactoryBot.create(:episode_head) }

  it 'is valid with valid attributes' do
    expect(episode_head).to be_valid
  end

  it 'knows its season' do
    expect(episode_head.season).to be_instance_of(Season)
  end

  it 'knows its serial' do
    expect(episode_head.serial).to be_instance_of(Serial)
  end
end
