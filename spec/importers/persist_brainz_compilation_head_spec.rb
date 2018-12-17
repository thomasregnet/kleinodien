# frozen_string_literal: true

require 'rails_helper'
require 'test_data'

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
        TestData.by_name(:brainz_release_group_arise).blueprint
      end

      it 'returns the persisted CompilationHead' do
        expect(described_class.call(blueprint: blueprint).title)
          .to eq('Dummy Head')
      end
    end

    context 'when the CompilationHead does not exist' do
      let(:blueprint) do
        TestData.by_name(:brainz_release_group_arise).blueprint
      end

      let(:sepultura) do
        TestData.by_name(:brainz_artist_sepultura).blueprint
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
