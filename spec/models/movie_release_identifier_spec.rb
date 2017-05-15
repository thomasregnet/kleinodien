require 'rails_helper'
require 'shared_examples_for_identifiers'

RSpec.describe MovieReleaseIdentifier, type: :model do
  it_behaves_like 'an identifier' do
    let(:identifier) { FactoryGirl.build(:movie_release_identifier) }
  end
end
