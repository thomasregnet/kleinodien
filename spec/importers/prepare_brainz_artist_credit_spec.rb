# frozen_string_literal: true

require 'fake_proxy'
require 'mock_import_order'
require 'rails_helper'
require 'shared_examples_for_services'
require 'test_data'

RSpec.describe PrepareBrainzArtistCredit do
  it_behaves_like 'a service'

  # TODO: Add some specs to PrepareBrainzArtistCredit
  describe '.call' do
    let(:arise) do
      TestData.by_name(:brainz_release_arise_jp_cd).blueprint.artist_credit
    end

    let(:sepultura) do
      TestData.by_name(:brainz_artist_sepultura).blueprint
    end

    let(:proxy) { FakeProxy.new }

    before do
      described_class.call(
        blueprint:    arise,
        import_order: MockImportOrder.new,
        proxy:        proxy
      )
    end

    it 'requests the artist' do
      expect(proxy.matches(%r{/artist/})).to eq(1)
    end

    it 'requests only the artist' do
      expect(proxy.cache_size).to eq(1)
    end
  end
end
