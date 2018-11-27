# frozen_string_literal: true

require 'ko_test_data'
require 'rails_helper'

RSpec.describe PersistBrainzArtist do
  context 'when the Artist does not exist' do
    describe '.call' do
      let(:blueprint) do
        xml_string = KoTestData::GetBrainzXmlFor.path(
          'artist/bdacc37b-8633-4bf8-9dd5-4662ee651aec'\
            '?inc=artist-rels+url-rels.xml'
        )
        BrainzBlueprint.from_xml(xml_string)
      end

      it 'persists the Artist' do
        expect(described_class.call(blueprint: blueprint))
          .to be_instance_of(Artist)
      end
    end
  end
end
