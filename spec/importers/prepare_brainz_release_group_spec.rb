# frozen_string_literal: true

require 'fake_proxy'
require 'rails_helper'
require 'test_data'
require 'shared_examples_for_services'

RSpec.describe PrepareBrainzReleaseGroup do
  it_behaves_like 'a service'

  context 'when the ReleaseHead does not exist' do
    let(:import_request) do
      FactoryBot.create(
        :brainz_release_group_import_request,
        code: '7d31891f-b9da-36de-ab08-98b1fdbbb023'
      )
    end

    let(:blueprint) do
      TestData.by_name(:brainz_release_the_sky_is_falling_gb_cd)
              .blueprint
              .release_group
    end

    let(:proxy) { FakeProxy.new }
    let(:preparer) do
      described_class.new(
        import_order:   :fake_import_order,
        import_request: import_request,
        proxy:          proxy
      )
    end

    before { preparer.prepare }

    it 'calls #prepare_artist_credit' do
      expect(proxy.get_calls).to eq(3)
    end

    it 'fills the proxy with three items' do
      expect(proxy.cache_size).to eq(3)
    end

    it 'adds two artists to the proxy cache' do
      expect(proxy.matches(%r{/artist/})).to eq(2)
    end

    it 'adds one release-group to the proxy cache' do
      expect(proxy.matches(%r{/release-group/})).to eq(1)
    end
  end
end
