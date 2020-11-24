# frozen_string_literal: true

require 'rails_helper'
require 'test_data/get_empty_image_service'

RSpec.describe 'releases/show', type: :view do
  describe '"Add to my collection" link' do
    let(:release) { FactoryBot.build(:album) }

    before { assign(:release, release) }

    context 'with an authenticated user' do
      let(:user) { FactoryBot.create(:user) }

      before do
        sign_in(user)
        allow(view).to receive(:user_signed_in?).and_return(true)
        render
      end

      it 'contains the link' do
        expect(rendered).to match(/Add to my collection/)
      end
    end

    context 'without an authenticated user' do
      it 'does not contain the link' do
        allow(view).to receive(:user_signed_in?).and_return(false)
        render
        expect(rendered).not_to match(/Add to my collection/)
      end
    end
  end

  describe 'Format' do
    let(:release) { FactoryBot.build(:album) }

    before do
      cd_format = FactoryBot.build(:medium_format, name: 'CD')
      lp_format = FactoryBot.build(:medium_format, name: 'LP')

      release.media.build(position: 1, format: cd_format, quantity: 2)
      release.media.build(position: 2, format: lp_format, quantity: 3)
      allow(view).to receive(:user_signed_in?).and_return(false)

      assign(:release, release)
    end

    it 'shows the first format (2 x CD)' do
      render
      expect(rendered).to match(/2\s+&times\s+CD/)
    end

    it 'shows the second format (3 x LP)' do
      render
      expect(rendered).to match(/3\s+&times\s+LP/)
    end
  end

  describe 'font cover' do
    let(:image) { Image.create! }
    let(:release) { FactoryBot.create(:release) }
    let(:release_image) { release.images.create!(image: image) }

    before do
      release_image.file.attach(io: TestData::GetEmptyImageService.as_io, filename: 'an_image')

      assign(:release, release)
      allow(controller).to receive(:user_signed_in?).and_return(false)
    end

    context 'with a front cover' do
      before do
        release_image.front_cover = true
        release_image.save!
      end

      it 'shows the image' do
        render
        expect(rendered).to match(/<img src="http/)
      end
    end

    context 'without a front cover' do
      it 'shows the image' do
        render
        expect(rendered).not_to match(/<img src="http/)
      end
    end
  end

  describe 'Import order' do
    let(:release) { FactoryBot.create(:album, import_order: FactoryBot.create(:import_order)) }

    before do
      assign(:release, release)
    end

    context 'without an user' do
      it 'does not show the Import order' do
        allow(view).to receive(:user_signed_in?).and_return(false)
        allow(controller).to receive(:current_user)
        render
        expect(rendered).not_to match(/Import order/)
      end
    end

    context 'without an authorized user' do
      it 'does not show the Import order' do
        user = FactoryBot.create(:user)

        allow(view).to receive(:user_signed_in?).and_return(true)
        allow(controller).to receive(:current_user).and_return(user)
        render
        expect(rendered).not_to match(/Import order/)
      end
    end

    context 'with an authorized user' do
      it 'shows the Import order' do
        user = FactoryBot.create(:user, importer: true)
        allow(controller).to receive(:current_user).and_return(user)
        render
        expect(rendered).to match(/Import order/)
      end
    end

    context 'with an authorized user but without an ImportOrder' do
      it 'shows the Import order' do
        release.import_order = nil
        user = FactoryBot.create(:user, importer: true)

        allow(view).to receive(:user_signed_in?).and_return(true)
        allow(view).to receive(:current_user).and_return(user)
        render
        expect(rendered).not_to match(/Import order/)
      end
    end
  end

  describe 'subset title' do
    before do
      release = FactoryBot.create(:album)
      release.subsets << ReleaseSubset.new(title: 'My subset title')
      allow(view).to receive(:user_signed_in?).and_return(true)
      assign(:release, release)
    end

    it 'shows the subset title' do
      render
      expect(rendered).to match(/My subset title/)
    end
  end
end
