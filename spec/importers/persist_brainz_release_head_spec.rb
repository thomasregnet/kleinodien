# frozen_string_literal: true

require 'rails_helper'
require 'test_data'

# Fake a BrainzProxy
class MockPersistBrainzReleaseHeadProxy
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
RSpec.describe PersistBrainzReleaseHead do
  describe '.call' do
    context 'when the ReleaseHead already exists' do
      before do
        FactoryBot.create(
          :release_head,
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

      it 'returns the persisted ReleaseHead' do
        args = {
          import_order:   :fake,
          import_request: import_request,
          proxy:          MockPersistBrainzReleaseHeadProxy.new
        }
        expect(described_class.call(args).title).to eq('Dummy Head')
      end
    end

    context 'when the ReleaseHead does not exist' do
      let(:blueprint) do
        TestData.by_name(:brainz_release_group_arise).blueprint
      end

      let(:release_head) do
        persister = described_class.new(
          import_order:   FactoryBot.create(:brainz_import_order),
          import_request: :fake_import_request,
          proxy:          :fake_proxy
        )

        allow(persister).to receive(:persist_artist_credit)
          .and_return(FactoryBot.create(:artist_credit))
        allow(persister).to receive(:blueprint)
          .and_return(blueprint)
        persister.persist
      end

      it 'returns a SingleHead' do
        expect(release_head).to be_instance_of(SingleHead)
      end

      it 'sets the ImportOrder' do
        expect(release_head.import_order).to be_kind_of(ImportOrder)
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
