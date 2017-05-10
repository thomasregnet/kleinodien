require 'rails_helper'
require 'shared_examples_for_identifyable'

RSpec.describe EpisodeHead, type: :model do
  before(:each) do
    @episode_head = FactoryGirl.create(:episode_head)
  end

  it 'is valid with valid attributes' do
    expect(@episode_head).to be_valid
  end

  it 'knows its season' do
    expect(@episode_head.season).to be_instance_of(Season)
  end

  it 'knows its serial' do
    expect(@episode_head.serial).to be_instance_of(Serial)
  end

  it_behaves_like 'an identifyable model' do
    before(:each) do
      @episode_head = FactoryGirl.create(:episode_head_with_identifiers)
    end

    let(:identifyable) { @episode_head }
  end
end
