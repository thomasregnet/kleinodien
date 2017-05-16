require 'rails_helper'
require 'shared_examples_for_pieces'
require 'shared_examples_for_identifyable'

RSpec.describe SongRelease, type: :model do
  before(:each) do
    @song_release = FactoryGirl.create(:song_release)
  end

  it 'is valid with valid attributes' do
    expect(@song_release).to be_valid
  end

  it 'is not valid without a head' do
    @song_release.head = nil
    expect(@song_release).not_to be_valid
  end

  it_behaves_like 'a piece' do
    let(:piece) { @song_release }
  end

  it_behaves_like 'an identifyable model' do
    let(:identifyable) { FactoryGirl.create(:song_release_with_identifiers) }
  end
end
