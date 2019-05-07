# frozen_string_literal: true

require 'rails_helper'
require 'shared_examples_for_import_state_transitions'
require 'shared_examples_for_import_requests'

RSpec.describe ImportRequest, type: :model do
  # TODO: add some specs for the base-class
  # For now no specs here. The "type"-column is "NOT NULL" so
  # all specs fail because in rails the "type" of the base-class is nil.
  # https://stackoverflow.com/questions/4858122/rails-sti-and-the-setting-of-the-type-string
  # include_examples 'for ImportRequests', :import_request

  # it_behaves_like(
  #   'an import state transitions capable object',
  #   :import_request
  # )

  it { is_expected.to have_many(:attempts) }
  it { is_expected.to have_one(:body) }

  it 'has a counter_cache for import_request_attempts' do
    import_request = FactoryBot.create(:brainz_artist_import_request)
    import_request.attempts.create!(status_code: 200)
    expect(import_request.attempts_count).to eq(1)
  end
end
