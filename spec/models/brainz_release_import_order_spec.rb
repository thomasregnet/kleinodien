# frozen_string_literal: true

require 'rails_helper'
require 'shared_examples_for_import_orders'

RSpec.describe BrainzReleaseImportOrder, type: :model do
  it_behaves_like 'for ImportOrders', :brainz_release_import_order

  context 'with valid attributes' do
    let(:import_order) { FactoryBot.create(:brainz_release_import_order) }

    it 'is valid' do
      expect(import_order).to be_valid
    end
  end

  context 'without an queue_name' do
    let(:import_order) { FactoryBot.create(:brainz_release_import_order) }

    it 'sets the default value' do
      import_order.import_queue = nil
      import_order.valid?

      expect(import_order.import_queue.name).to eq('brainz')
    end
  end
end
