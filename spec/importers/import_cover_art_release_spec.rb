# frozen_string_literal: true

require 'rails_helper'
require 'shared_examples_for_importers'

RSpec.describe ImportCoverArtRelease do
  subject do
    described_class.new(import_order: FactoryBot.build(:cover_art_release_import_order))
  end

  it_behaves_like 'an importer'

  context 'when images are available' do
    let(:brainz_code) { 'b4bdc9c6-a3c0-4e50-a6f5-fe6ec5e66609' }
    let(:import_order) { FactoryBot.create(:cover_art_release_import_order, code: brainz_code) }
    let(:release) { Release.find_by(brainz_code: brainz_code) }

    before do
      FactoryBot.create(:release, brainz_code: 'b4bdc9c6-a3c0-4e50-a6f5-fe6ec5e66609')
      described_class.call(import_order: import_order)
    end

    context 'with an image that does not exist in the database' do
      it 'attaches cover images to the release' do
        expect(release.images.length).to be > 0
      end

      it "saves it's ImportOrder" do
        release.images.each do |release_image|
          expect(release_image.import_order).to be_instance_of(CoverArtReleaseImportOrder)
        end
      end

      it 'saves the coverartarchive types as tags' do
        image = release.images.first
        expect(image.tags.length).to eq(1)
      end

      it 'saves the expected tags' do
        image = release.images.first
        expect(image.tags.first.name).to eq('Front')
      end
    end

    context 'with an image that exists in the database' do
      before do
        allow(Image).to receive(:find_by).and_return(Image.new)
      end

      it 'attaches cover images to the release' do
        expect(release.images.length).to be > 0
      end

      it "saves it's ImportOrder" do
        release.images.each do |release_image|
          expect(release_image.import_order).to be_instance_of(CoverArtReleaseImportOrder)
        end
      end
    end
  end

  context 'when there are no images to import' do
    let(:brainz_code) { 'b4bdc9c6-a3c0-4e50-a6f5-eeeeeeeee404' }
    let(:import_order) { FactoryBot.create(:cover_art_release_import_order, code: brainz_code) }
    let(:release) { Release.find_by(brainz_code: brainz_code) }

    before do
      FactoryBot.create(:release, brainz_code: brainz_code)
      allow(CoverArtFetcher).to receive(:call).and_return(nil)
      described_class.call(import_order: import_order)
    end

    it 'attaches cover images to the release' do
      expect(release.images.length).to be(0)
    end
  end

  describe '#find_existing' do
    let(:brainz_code) { '43c1b085-7f75-407a-b087-f46b64260d76' }
    let(:image) { FactoryBot.create(:image, coverartarchive_code: 987_654_321) }
    let(:importer) { described_class.new(import_order: import_order) }
    let(:import_order) { FactoryBot.create(:cover_art_release_import_order, code: brainz_code) }
    let(:release) { FactoryBot.create(:release, brainz_code: brainz_code) }

    context 'when there is at least one front-cover imported from coverartarchive.org' do
      before do
        release.images.create!(front_cover: true, image: image)
      end

      it 'returns true' do
        expect(importer.find_existing).to be(true)
      end
    end

    context 'when there is an image imported from coverartarchive.org but not a front_cover' do
      before do
        release.images.create!(front_cover: false, image: image)
      end

      it 'returns true' do
        expect(importer.find_existing).to be(false)
      end
    end

    context 'when there is no image' do
      it 'returns true' do
        expect(importer.find_existing).to be(false)
      end
    end
  end
end
