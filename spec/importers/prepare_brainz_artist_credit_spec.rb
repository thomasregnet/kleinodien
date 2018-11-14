# frozen_string_literal: true

require 'rails_helper'
require 'shared_examples_for_services'
require 'ko_test_data'
RSpec.describe PrepareBrainzArtistCredit do
  it_behaves_like 'a service'

  describe '.call' do
    let(:blueprint) do
      KoTestData::GetBrainzBlueprintFor.uri(
        'release/7452f8c9-f9bc-3ca7-859e-3220e57e4e4a' \
          '?inc=artists+labels+recordings+release-groups.xml'
      )
    end

    it 'requests the artist' do
      proxy = spy
      described_class.call(
        blueprint: blueprint,
        proxy:     proxy
      )
      expect(proxy).to have_received(:get)
    end
  end
end
