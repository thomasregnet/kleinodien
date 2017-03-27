require 'rails_helper'

RSpec.describe BrainzRelease, type: :model do
  before(:each) do
    @brainz_release = FactoryGirl.build(:brainz_release)
  end

  it 'is not valid without a mbid' do
    @brainz_release.mbid = nil
    expect(@brainz_release).not_to be_valid
  end

  it 'is not valid without an url' do
    @brainz_release.url = nil
    expect(@brainz_release).not_to be_valid
  end

  it 'is not valid with a blank url' do
    @brainz_release.url = ''
    expect(@brainz_release).not_to be_valid
  end

  it 'is not valid without data' do
    @brainz_release.data = nil
    expect(@brainz_release).not_to be_valid
  end

  it 'is not valid with blank data' do
    @brainz_release.data = ''
    expect(@brainz_release).not_to be_valid
  end

  it 'is saveable' do
    expect(@brainz_release.save).to be true
  end
end
