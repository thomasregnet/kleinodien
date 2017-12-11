require 'rails_helper'
require 'ko_test_data'

RSpec.describe MashedBrainz do
  describe '.from_xml' do
    context 'with artist xml as parameter' do
      it 'returns a MashedBrainz::Artist object' do
        reference = BrainzArtistReference.from_code(
          '1d93c839-22e7-4f76-ad84-d27039efc048'
        )

        xml = KoTestData.brainz_xml_for(reference)
        expect(MashedBrainz.from_xml(xml))
          .to be_instance_of MashedBrainz::Artist
      end
    end

    context 'with release xml as prameter' do
      it 'returns a MashedBrainz::Release object' do
        reference = BrainzReleaseReference.from_code(
          '693748be-7c18-39c3-af2e-2e62092090cf'
        )

        xml = KoTestData.brainz_xml_for(reference)
        expect(MashedBrainz.from_xml(xml))
          .to be_instance_of MashedBrainz::Release
      end
    end

    context 'with release-group xml as parameter' do
      it 'returns a MashedBrainz::ReleaseGroup object' do
        reference = BrainzReleaseGroupReference.from_code(
          '7d31891f-b9da-36de-ab08-98b1fdbbb023'
        )

        xml = KoTestData.brainz_xml_for(reference)
        expect(MashedBrainz.from_xml(xml))
          .to be_instance_of MashedBrainz::ReleaseGroup
      end
    end
  end
end
