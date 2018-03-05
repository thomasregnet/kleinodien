require 'rails_helper'

RSpec.describe Import::Queue::Get do
  describe '.perform' do
    let(:uri) do
      'http://musicbrainz.org/ws/2/artist/'\
      '1d93c839-22e7-4f76-ad84-d27039efc048?inc=url-rels.xml'
    end

    it 'returns the requested data' do
      expect(described_class.perform(uri: uri))
        .to be_instance_of(Faraday::Response)
    end
  end
end
