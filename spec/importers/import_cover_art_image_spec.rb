# frozen_string_literal: true

require 'rails_helper'
require 'shared_examples_for_services'

RSpec.describe ImportCoverArtImage do
  it_behaves_like 'a service'

  context 'with tags' do
    let(:import_order) { FactoryBot.create(:import_order, code: '58bf252a-30b2-11eb-985d-08606e75dc17') }
    let(:importer) do
      described_class.new(
        import_order:  import_order,
        metadata:      metadata,
        target_object: target_object
      )
    end
    let(:metadata) do
      {
        back:  false,
        front: false,
        id:    123,
        image: 'https://coverartarchive.org/release/58bf252a-30b2-11eb-985d-08606e75dc17/123',
        types: tags
      }
    end
    let(:tags) { %w[existing_tag another_tag] }
    let(:target_object) { FactoryBot.build(:release_image) }

    before do
      ImageTag.create!(name: 'Existing_Tag')
      importer.call
    end

    it 'sets the tags' do
      expect(target_object.tags.map { |tag| tag.name }).to eq(%w[Existing_Tag another_tag])
    end
  end

  describe '#find_existing' do
    let(:id) { 123 }
    let(:importer) do
      described_class.new(
        import_order:  FactoryBot.create(:import_order),
        metadata:      { id: id },
        target_object: :fake_object
      )
    end

    context 'when the image does exist' do
      before do
        FactoryBot.create(:image, coverartarchive_code: id)
      end

      it 'returns that image' do
        expect(importer.find_existing.coverartarchive_code).to be(id)
      end
    end

    context 'when the image does not already exist' do
      it 'returns nil' do
        expect(importer.find_existing).to be(nil)
      end
    end
  end

  describe '#persist' do
    let(:importer) do
      described_class.new(
        import_order:  FactoryBot.create(:import_order),
        metadata:      { id: 123 },
        target_object: target_object
      )
    end

    let(:target_object) { instance_double('ReleaseImage') }

    before do
      allow(importer).to receive(:image)

      allow(target_object).to receive(:back_cover=)
      allow(target_object).to receive(:front_cover=)
      allow(target_object).to receive(:image=)
      allow(target_object).to receive(:import_order=)
      allow(target_object).to receive(:note=)
      allow(target_object).to receive(:save!)
      allow(target_object).to receive(:tags).and_return(nil)
    end

    it 'returns the targe_object' do
      expect(importer.persist).to be(target_object)
    end
  end

  describe '#prepare' do
    let(:importer) do
      described_class.new(
        import_order:  FactoryBot.create(:import_order),
        metadata:      { id: 123 },
        target_object: :fake_object
      )
    end

    before do
      response = instance_double('Faraday::Response')
      allow(CoverArtImageImportRequest).to receive(:create!)
      allow(CoverArtFetcher).to receive(:call).and_return(response)
      allow(response).to receive(:body).and_return('fake image')
    end

    it 'returns an StringIO object' do
      expect(importer.prepare).to be_instance_of(StringIO)
    end
  end
end
