# frozen_string_literal: true

require 'ko_test_data'
require 'rails_helper'

RSpec.describe PersistBrainzArtist do
  context 'when the Artist does not exist' do
    describe '.call' do
      let(:artist) do
        xml_string = KoTestData::GetBrainzXmlFor.path(
          'artist/bdacc37b-8633-4bf8-9dd5-4662ee651aec'\
            '?inc=artist-rels+url-rels.xml'
        )
        blueprint = BrainzBlueprint.from_xml(xml_string)
        described_class.call(blueprint: blueprint)
      end

      it 'persists the Artist' do
        expect(artist).to be_instance_of(Artist)
      end

      it 'sets the name' do
        expect(artist.name).to eq('Slayer')
      end

      it 'sets the begin_date' do
        expect(artist.begin_date.year).to eq(1981)
      end
    end
  end
end
