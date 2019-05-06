# frozen_string_literal: true

require 'rails_helper'
require 'aasm/rspec'
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

  describe 'constraints and validations on code' do
    context 'when state is "pending"' do
      # TODO: do not use BrainzImportOrder to test ImportOrder
      # therefore the NOT NULL constraint for "type" must be deleted
      subject { FactoryBot.create(:brainz_import_order, state: 'pending') }

      it { should validate_uniqueness_of(:code).scoped_to(:kind, :type) }
    end

    context 'when state is "processing"' do
      subject { FactoryBot.create(:brainz_import_order, state: 'processing') }

      it { should validate_uniqueness_of(:code).scoped_to(:kind, :type) }
    end

    context 'when state is "done"' do
      subject { FactoryBot.create(:brainz_import_order, state: 'done') }

      it { should_not validate_uniqueness_of(:code).scoped_to(:kind, :type) }
    end

    context 'when state is "failed"' do
      subject { FactoryBot.create(:brainz_import_order, state: 'failed') }

      it { should_not validate_uniqueness_of(:code).scoped_to(:kind, :type) }
    end
  end

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

  describe 'state' do
    context 'when pending' do
      let(:import_order) do
        FactoryBot.create(:import_order, type: 'FakeImportOrder')
      end

      it 'transits to processing' do
        expect(import_order)
          .to transition_from(:pending).to(:processing).on_event(:process)
      end

      it 'does not transit to done' do
        expect(import_order)
          .not_to allow_event(:done)
      end

      it 'does not transit to failed' do
        expect(import_order)
          .not_to allow_event(:failed)
      end
    end

    context 'when processing' do
      let(:import_order) do
        FactoryBot.create(
          :import_order,
          type:  'FakeImportOrder',
          state: :processing
        )
      end

      it 'transits to done' do
        expect(import_order)
          .to transition_from(:processing).to(:done).on_event(:done)
      end

      it 'transits to failed' do
        expect(import_order)
          .to transition_from(:processing).to(:failed).on_event(:failure)
      end

      it 'does not transit to pending' do
        expect(import_order).not_to allow_event(:pending)
      end
    end

    context 'when done' do
      let(:import_order) do
        FactoryBot.create(
          :import_order,
          type:  'FakeImportOrder',
          state: :done
        )
      end

      it 'does not transit to pending' do
        expect(import_order).not_to allow_event(:pending)
      end

      it 'does not transit to processing' do
        expect(import_order).not_to allow_event(:processing)
      end

      it 'does not transit to failed' do
        expect(import_order).not_to allow_event(:failed)
      end
    end

    context 'when failed' do
      let(:import_order) do
        FactoryBot.create(
          :import_order,
          type:  'FakeImportOrder',
          state: :done
        )
      end

      it 'does not transit to pending' do
        expect(import_order).not_to allow_event(:pending)
      end

      it 'does not transit to processing' do
        expect(import_order).not_to allow_event(:processing)
      end

      it 'does not transit to done' do
        expect(import_order).not_to allow_event(:done)
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
