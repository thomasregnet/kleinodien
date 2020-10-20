# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'releases/show', type: :view do
  describe 'Format' do
    let(:release) { FactoryBot.build(:album) }

    before do
      cd_format = FactoryBot.build(:medium_format, name: 'CD')
      lp_format = FactoryBot.build(:medium_format, name: 'LP')

      release.media.build(position: 1, format: cd_format, quantity: 2)
      release.media.build(position: 2, format: lp_format, quantity: 3)

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

  describe 'Import order' do
    let(:release) { FactoryBot.create(:album, import_order: FactoryBot.create(:import_order)) }

    before do
      assign(:release, release)
    end

    context 'without an user' do
      it 'does not show the Import order' do
        allow(controller).to receive(:current_user)
        render
        expect(rendered).not_to match(/Import order/)
      end
    end

    context 'without an authorized user' do
      it 'does not show the Import order' do
        user = FactoryBot.create(:user)
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
        allow(controller).to receive(:current_user).and_return(user)
        render
        expect(rendered).not_to match(/Import order/)
      end
    end
  end

  describe 'subset title' do
    before do
      release = FactoryBot.create(:album)
      release.subsets << ReleaseSubset.new(title: 'My subset title')
      assign(:release, release)
    end

    it 'shows the subset title' do
      render
      expect(rendered).to match(/My subset title/)
    end
  end
end
