# frozen_string_literal: true

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

    it 'requests the artist' do
      proxy = double # spy
      args  = { blueprint: arise, proxy: proxy }
      allow(proxy).to receive(:get).and_return(sepultura)

      expect(described_class.call(args)).to be_nil
    end
  end
end
