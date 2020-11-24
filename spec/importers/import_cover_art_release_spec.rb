# frozen_string_literal: true

require 'rails_helper'
require 'shared_examples_for_services'

RSpec.describe ImportCoverArtRelease do
  it_behaves_like 'a service'

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
end
