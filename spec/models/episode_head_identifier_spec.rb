require 'rails_helper'
require 'shared_examples_for_identifiers'

RSpec.describe EpisodeHeadIdentifier, type: :model do
  it_behaves_like 'an identifier' do
    let(:identifier) { FactoryBot.build(:episode_head_identifier) }
  end
end
