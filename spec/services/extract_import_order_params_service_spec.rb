require 'rails_helper'
require 'shared_examples_for_services'

RSpec.describe ExtractImportOrderParamsService do
  it_behaves_like 'a service'

  context 'with a valid uri' do
    uri_string = 'https://musicbrainz.org/artist/123'
    let(:result) { described_class.call(uri_string) }

    it 'returns the code' do
      expect(result[:code]).to eq('123')
    end

    it 'returns the kind' do
      expect(result[:kind]).to eq 'artist'
    end

    # TODO it returns the type
  end
end
