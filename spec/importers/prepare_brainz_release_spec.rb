# frozen_string_literal: true

require 'fake_proxy'
require 'mock_import_order'
require 'rails_helper'
require 'shared_examples_for_services'
require 'test_data'

RSpec.describe PrepareBrainzRelease do
  it_behaves_like 'a service'

  describe '.call' do
    context 'when the release is not already persisted' do
      let(:stub) do
        TestData.by_name(:brainz_release_arise_jp_cd).blueprint
      end

      # rubocop:disable RSpec/InstanceVariable
      before do
        @proxy = FakeProxy.new
        described_class.call(
          import_order: MockImportOrder.new,
          proxy:        @proxy,
          stub:         stub
        )
      end

      it 'has requested the area' do
        expect(@proxy).to be_requested_for(%r{/area/}, 2)
      end

      it 'has requested the artist' do
        expect(@proxy).to be_requested_for(%r{/artist/}, 1)
      end

      it 'has requested the label' do
        expect(@proxy).to be_requested_for(%r{/label/}, 1)
      end

      it 'has requested the recording' do
        expect(@proxy).to be_requested_for(%r{/recording/}, 3)
      end

      it 'has requested the release-group' do
        expect(@proxy).to be_requested_for(%r{/release-group/}, 1)
      end

      it 'has requested the release' do
        expect(@proxy).to be_requested_for(%r{/release/}, 1)
      end
      # rubocop:enable RSpec/InstanceVariable
    end

    context 'when the release is already persisted' do
      let(:proxy) { FakeProxy.new }
      let(:stub) do
        TestData.by_name(:brainz_release_arise_jp_cd).blueprint
      end

      before do
        FactoryBot.create(:release, brainz_code: stub.brainz_code)

        described_class.call(
          import_order: MockImportOrder.new,
          proxy:        proxy,
          stub:         stub
        )
      end

      it 'does not requested anything on the proxy' do
        expect(proxy).not_to be_requested
      end
    end
  end
end
