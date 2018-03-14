require 'rails_helper'
require 'shared_examples_for_services'

RSpec.describe QueueBrainzReleaseRequestService do
  before { DatabaseCleaner.start }

  it_behaves_like 'a service'

  let(:import_request) { FactoryBot.build(:brainz_release_import_request) }

  describe '.call' do
    # described_class.call(import_request)

    it 'has queued the request' do
      described_class.call(import_request)
      expect(GetImportStoreService.call.lindex('brainz:queue', 0)).not_to be nil
    end
  end

  after { DatabaseCleaner.clean }
end
