# frozen_string_literal: true

require 'rails_helper'
require 'test_data'

# Fake a BrainzProxy
class MockPersistBrainzHeapHeadProxy
  def initialize
    @arise     = TestData.by_name(:brainz_release_group_arise).blueprint
    @sepultura = TestData.by_name(:brainz_artist_sepultura).blueprint
  end

  attr_reader :arise, :sepultura

  def get(import_request)
    return arise if import_request.to_uri =~ /5fc9ba9d/

    sepultura
  end
end

# rubocop:disable Metrics/BlockLength
RSpec.describe PersistBrainzHeapHead do
  describe '.call' do
    context 'when the HeapHead already exists' do
      before do
        FactoryBot.create(
          :heap_head,
          brainz_code: '5fc9ba9d-bc39-38fc-a479-eadbf0f3a933',
          title:       'Dummy Head'
        )
      end

      let(:blueprint) do
        TestData.by_name(:brainz_release_group_arise).blueprint
      end

      let(:import_request) do
        brainz_code = TestData.by_name(:brainz_release_group_arise)
                              .blueprint.brainz_code
        BrainzReleaseGroupImportRequest.new(code: brainz_code)
      end

      it 'returns the persisted HeapHead' do
        args = {
          import_request: import_request,
          proxy:          MockPersistBrainzHeapHeadProxy.new
        }
        expect(described_class.call(args).title).to eq('Dummy Head')
      end
    end

    context 'when the HeapHead does not exist' do
      let(:blueprint) do
        TestData.by_name(:brainz_release_group_arise).blueprint
      end

      let(:sepultura) do
        TestData.by_name(:brainz_artist_sepultura).blueprint
      end

      it 'returns a HeapHead' do
        proxy = MockPersistBrainzHeapHeadProxy.new

        args = {
          import_request: BrainzReleaseGroupImportRequest.new(
            code: blueprint.brainz_code
          ),
          proxy:          proxy
        }

        expect(described_class.call(args))
          .to be_instance_of(AlbumHead)
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
