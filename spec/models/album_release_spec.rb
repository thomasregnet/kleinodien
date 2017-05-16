require 'rails_helper'
require 'shared_examples_for_identifyable'

RSpec.describe AlbumRelease, type: :model do
  it_behaves_like 'an identifyable model' do
    let(:identifyable) { FactoryGirl.create(:album_release_with_identifiers) }
  end
end
