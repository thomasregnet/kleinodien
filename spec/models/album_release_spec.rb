require 'rails_helper'
require 'shared_examples_for_identifyable'

RSpec.describe AlbumRelease, type: :model do
  it_behaves_like 'an identifyable model' do
    before(:each) do
      @album_release = FactoryGirl.create(:album_release_with_identifiers)
    end

    let(:identifyable) { @album_release }
  end
end
