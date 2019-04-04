# frozen_string_literal: true

require 'rails_helper'
require 'shared_examples_for_import_orders'

# just for testing
class FakeImportOrder < ImportOrder
end

# just for testing
class OtherFakeImportOrder < ImportOrder
end

# rubocop:disable Metrics/BlockLength
RSpec.describe ImportOrder, type: :model do
  include_examples 'for ImportOrders', :import_order

  it { is_expected.to have_many(:artist_credits) }
  it { is_expected.to have_many(:artists) }
  it { is_expected.to have_many(:heap_heads) }
  it { is_expected.to have_many(:heap_tracks) }
  it { is_expected.to have_many(:heaps) }
  it { is_expected.to have_many(:medium_formats) }
  it { is_expected.to have_many(:piece_heads) }
  it { is_expected.to have_many(:pieces) }

  describe '.next_pending' do
    context 'when no ImportOrder exists' do
      it 'returns nil' do
        expect(described_class.next_pending).to be_nil
      end
    end

    context 'when an ImportOrder exist' do
      before do
        FactoryBot.create(:import_order, type: 'FakeImportOrder')
      end

      it 'returns that order' do
        expect(FakeImportOrder.next_pending).to be_instance_of(FakeImportOrder)
      end
    end

    context 'when another ImportOrder exists' do
      before do
        FactoryBot.create(:import_order, type: 'OtherFakeImportOrder')
        FactoryBot.create(:import_order, type: 'FakeImportOrder')
      end

      it 'returns that order' do
        expect(FakeImportOrder.next_pending)
          .to be_instance_of(FakeImportOrder)
      end
    end

    context 'when only another ImportOrder exists' do
      before do
        FactoryBot.create(:import_order, type: 'OtherFakeImportOrder')
      end

      it 'returns that order' do
        expect(FakeImportOrder.next_pending).to be_nil
      end
    end
  end

  it 'has a counter_cache for import_requests' do
    request_args = {
      type: 'BrainzArtistImportRequest',
      code: 'b65a263c-f3c7-11e8-a665-7be5100d3866'
    }
    import_order = FactoryBot.create(:brainz_import_order)
    import_order.import_requests.create(request_args)
    expect(import_order.requests_count).to eq(1)
  end
end
# rubocop:enable Metrics/BlockLength
