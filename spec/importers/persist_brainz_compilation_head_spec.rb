# frozen_string_literal: true

require 'rails_helper'
require 'test_data'

# Fake a BrainzProxy
class MockPersistBrainzCompilationHeadProxy
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

RSpec.describe PersistBrainzCompilationHead do
  describe '.call' do
    context 'when the CompilationHead already exists' do
      before do
        FactoryBot.create(
          :compilation_head,
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

      it 'returns the persisted CompilationHead' do
        args = {
          import_request: import_request,
          proxy:          MockPersistBrainzCompilationHeadProxy.new
        }
        expect(described_class.call(args).title).to eq('Dummy Head')
      end
    end

    context 'when the CompilationHead does not exist' do
      let(:blueprint) do
        TestData.by_name(:brainz_release_group_arise).blueprint
      end

      let(:sepultura) do
        TestData.by_name(:brainz_artist_sepultura).blueprint
      end

      it 'returns a CompilationHead' do
        proxy = MockPersistBrainzCompilationHeadProxy.new

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
