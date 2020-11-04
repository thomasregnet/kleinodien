# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'import_orders/show', type: :view do
  describe 'link to the item' do
    context 'when the state is "done"' do
      let(:import_order) { FactoryBot.create(:brainz_release_import_order, state: :done) }
      let(:release) { FactoryBot.create(:release) }

      before do
        assign(:import_order, import_order)
        allow(import_order).to receive(:item).and_return(release)
        allow(import_order).to receive(:item_designation).and_return('my designation')
        allow(import_order).to receive(:uri).and_return('https://data/source')
      end

      it 'links to the item' do
        render
        expect(rendered).to have_link('my designation')
      end
    end
  end

  context 'when the state is not "done"' do
    let(:import_order) { FactoryBot.create(:brainz_release_import_order, state: :pending) }

    before do
      assign(:import_order, import_order)
      allow(import_order).to receive(:item).and_return(nil)
      allow(import_order).to receive(:uri).and_return('https://data/source')
    end

    it 'links to the item' do
      render
      expect(rendered).not_to have_link('my designation')
    end
  end
end
