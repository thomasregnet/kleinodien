# frozen_string_literal: true

require 'rails_helper'
require 'shared_examples_for_services'

RSpec.describe GetImportOrderClassNameFromUriService do
  it_behaves_like 'a service'

  context 'with a valid Discogs uri_string' do
    let(:uri_string) do
      'https://www.discogs.com/de/ACDC-Let-There-Be-Rock/release/368686'
    end

    it 'returns "DiscogsImportOrder"' do
      expect(described_class.call(uri_string: uri_string))
        .to eq 'DiscogsImportOrder'
    end
  end

  context 'with a valid MusicBrainz uri_string' do
    let(:uri_string) do
      'https://musicbrainz.org/release/7d73370a-546d-4037-a40f-72669b6772e4'
    end

    it 'returns "BrainzImportOrder"' do
      expect(described_class.call(uri_string: uri_string))
        .to eq 'BrainzImportOrder'
    end
  end

  context 'with nil as uri_string' do
    it 'returns nil' do
      expect(described_class.call(uri_string: nil)).to eq nil
    end
  end

  context 'with an uri_string that contains no top level domain' do
    let(:uri_string) { 'https://notoplevel/release/123' }

    it 'returns nil' do
      expect(described_class.call(uri_string: uri_string)).to be nil
    end
  end

  context 'with nonsense as uri_string' do
    it 'returns nil' do
      expect(described_class.call(uri_string: 'foobar')).to eq nil
    end
  end
end
