# frozen_string_literal: true

require 'ko_test_data'
require 'rails_helper'

RSpec.describe PersistBrainzCompilationHead do
  describe '.call' do
    context 'when the CompilationHead already exists' do
      before do
        FactoryBot.create(
          :compilation_head,
          brainz_code: '5fc9ba9d-bc39-38fc-a479-eadbf0f3a933',
          title:       'Dummy Head'
        )
      end

      let(:blueprint) do
        xml_string = KoTestData::GetBrainzXmlFor.path(
          'release-group/5fc9ba9d-bc39-38fc-a479-eadbf0f3a933?' \
            'inc=artists+artist-rels+label-rels+url-rels.xml'
        )
        BrainzBlueprint.from_xml(xml_string)
      end

      it 'returns the persisted CompilationHead' do
        expect(described_class.call(blueprint: blueprint).title)
          .to eq('Dummy Head')
      end
    end

    context 'when the CompilationHead does not exist' do
      let(:blueprint) do
        xml_string = KoTestData::GetBrainzXmlFor.path(
          'release-group/5fc9ba9d-bc39-38fc-a479-eadbf0f3a933?' \
            'inc=artists+artist-rels+label-rels+url-rels.xml'
        )
        BrainzBlueprint.from_xml(xml_string)
      end

      let(:sepultura) do
        xml_string = KoTestData::GetBrainzXmlFor.path(
          'artist/1d93c839-22e7-4f76-ad84-d27039efc048?inc=url-rels.xml'
        )
        BrainzBlueprint.from_xml(xml_string)
      end

      it 'returns a CompilationHead' do
        proxy = instance_double('Proxy')
        allow(proxy).to receive(:get).and_return(sepultura)

        expect(described_class.call(blueprint: blueprint, proxy: proxy))
          .to be_instance_of(AlbumHead)
      end
    end
  end
end
