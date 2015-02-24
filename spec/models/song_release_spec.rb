require 'rails_helper'
require 'shared_examples_for_pieces'

RSpec.describe SongRelease, type: :model do
  before(:each) do
    @song_release = FactoryGirl.create(:song_release)
  end

  it "is valid with valid attributes" do
    expect(@song_release).to be_valid
  end

  it_behaves_like "a piece" do
    let(:piece) { @song_release }
  end
end
