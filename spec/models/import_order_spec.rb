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
  it { is_expected.to have_many(:release_heads) }
  it { is_expected.to have_many(:release_tracks) }
  it { is_expected.to have_many(:releases) }
  it { is_expected.to have_many(:medium_formats) }
  it { is_expected.to have_many(:piece_heads) }
  it { is_expected.to have_many(:pieces) }

  # rubocop:disable RSpec/ImplicitSubject
  describe 'constraints and validations on code' do
    context 'when state is "pending"' do
      # TODO: do not use BrainzImportOrder to test ImportOrder
      # therefore the NOT NULL constraint for "type" must be deleted
      subject { FactoryBot.create(:brainz_import_order, state: 'pending') }

      it {
        should validate_uniqueness_of(:code)
          .scoped_to(:import_queue_id, :type)
      }
    end

    context 'when state is "processing"' do
      subject { FactoryBot.create(:brainz_import_order, state: 'processing') }

      it {
        should validate_uniqueness_of(:code)
          .scoped_to(:import_queue_id, :type)
      }
    end

    context 'when state is "done"' do
      subject { FactoryBot.create(:brainz_import_order, state: 'done') }

      it {
        should_not validate_uniqueness_of(:code)
          .scoped_to(:import_queue_id, :type)
      }
    end

    context 'when state is "failed"' do
      subject { FactoryBot.create(:brainz_import_order, state: 'failed') }

      it {
        should_not validate_uniqueness_of(:code)
          .scoped_to(:import_queue_id, :type)
      }
    end
  end
  # rubocop:enable RSpec/ImplicitSubject

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

  describe '#save' do
    context 'when pending' do
      let(:import_order) do
        FactoryBot.build(:import_order, type: 'FakeImportOrder')
      end

      it 'publishes the pending ImportOrder' do
        redis = object_double('REDIS', publish: nil).as_stubbed_const
        import_order.save
        expect(redis).to have_received(:publish)
          .with('publish_fake_import_orders', 'run')
      end
    end

    context 'when not pending' do
      let(:import_order) do
        FactoryBot.build(
          :import_order,
          type:  'FakeImportOrder',
          state: :processing
        )
      end

      it 'does not publish the ImportOrder' do
        redis = object_double('REDIS', publish: nil).as_stubbed_const
        import_order.save
        expect(redis).not_to have_received(:publish)
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
