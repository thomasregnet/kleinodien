require 'rails_helper'
require 'shared_examples_for_identifiers'

RSpec.describe EpisodeReleaseIdentifier, type: :model do
  it_behaves_like 'an identifier' do
    let(:identifier) { FactoryGirl.build(:episode_release_identifier) }
  end
end
