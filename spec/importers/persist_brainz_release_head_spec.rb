# frozen_string_literal: true

require 'fake_proxy'
require 'rails_helper'
require 'test_data'

RSpec.describe PersistBrainzReleaseHead do
  describe '#persist' do
    let(:blueprint) do
      TestData.by_name(:brainz_release_group_arise).blueprint
    end

    let(:persister) do
      described_class.new(
        code:         blueprint.brainz_code,
        import_order: FactoryBot.create(:brainz_import_order),
        proxy:        FakeProxy.new
      )
    end

    let(:release_head) { persister.persist }

    context 'when the ReleaseHead does not exist in the database' do
      before do
        allow(persister).to receive(:persist_artist_credit).and_return(FactoryBot.create(:artist_credit))
        allow(persister).to receive(:blueprint).and_return(blueprint)

        persister.call
      end

      it 'returns a SingleHead' do
        expect(release_head).to be_instance_of(SingleHead)
      end

      it 'sets the ImportOrder' do
        expect(release_head.import_order).to be_kind_of(ImportOrder)
      end

      it 'sets the brainz_code' do
        expect(release_head.brainz_code).to eq('5fc9ba9d-bc39-38fc-a479-eadbf0f3a933')
      end
    end

    context 'when the ReleaseHead exists in the database' do
      before do
        FactoryBot.create(:release_head, brainz_code: '5fc9ba9d-bc39-38fc-a479-eadbf0f3a933')

        allow(persister).to receive(:persist_artist_credit).and_return(FactoryBot.create(:artist_credit))
        persister.proxy.lock 
        persister.call
      end

      it 'returns a SingleHead' do
        expect(release_head).to be_instance_of(SingleHead)
      end
    end
  end
end
