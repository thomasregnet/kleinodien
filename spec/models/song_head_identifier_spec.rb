require 'rails_helper'
require 'shared_examples_for_identifiers'

RSpec.describe SongHeadIdentifier, type: :model do
  it_behaves_like 'an identifier' do
    let(:identifier) { FactoryBot.build(:song_head_identifier) }
  end
end
