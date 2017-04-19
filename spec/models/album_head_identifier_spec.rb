require 'rails_helper'
require 'shared_examples_for_identifiers'

RSpec.describe AlbumHeadIdentifier, type: :model do
  it_behaves_like 'an identifier' do
    let(:identifier) { FactoryGirl.build(:album_head_identifier) }
  end
end
