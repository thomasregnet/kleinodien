# frozen_string_literal: true

require 'rails_helper'
require 'ko_test_data'

RSpec.describe PrepareBrainzArtist do
  context 'when the artist does not exist in the database' do
    let(:blueprint) do
      KoTestData::GetBrainzBlueprintFor.path(
        'artist/1d93c839-22e7-4f76-ad84-d27039efc048?inc=url-rels.xml'
      )
    end

    it 'calls the proxy' do
      proxy = spy
      described_class.call(
        blueprint: blueprint,
        proxy:     proxy
      )
      expect(proxy).to have_received(:get)
    end
  end
end
