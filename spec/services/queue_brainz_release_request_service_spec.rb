# frozen_string_literal: true

require 'rails_helper'
require 'shared_examples_for_services'

RSpec.describe QueueBrainzReleaseRequestService do
  before { DatabaseCleaner.start }

  let(:import_request) { FactoryBot.build(:brainz_release_import_request) }

  it_behaves_like 'a service'

  it 'queues the request' do
    described_class.call(import_request)
    expect(GetImportStoreService.call.llen('brainz:queue')).to eq(1)
  end

  after { DatabaseCleaner.clean }
end
