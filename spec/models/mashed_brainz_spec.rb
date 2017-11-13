require 'rails_helper'
require 'ko_test_data'

RSpec.describe MashedBrainz do
  describe '.from_xml' do
    context 'with an artist-xml as parameter' do
      it 'returns a MashedBrainz::Artist object' do
        reference = BrainzArtistRef.new(
          code: '1d93c839-22e7-4f76-ad84-d27039efc048'
        )

        xml = KoTestData.brainz_xml_for(reference)
        expect(MashedBrainz.from_xml(xml))
          .to be_instance_of MashedBrainz::Artist
      end
    end
  end
end
