# frozen_string_literal: true

require 'rails_helper'
require 'shared_examples_for_import_orders'

# just for testing
class FakeImportOrder < ImportOrder
  def self.default_import_queue_name
    'fake'
  end
end

# just for testing
class OtherFakeImportOrder < ImportOrder
  def self.default_import_queue_name
    'another_fake'
  end
end

# rubocop:disable Metrics/BlockLength
RSpec.describe ImportOrder, type: :model do
  # include_examples 'for ImportOrders', :import_order

  # The ImportQueue is set automatically, so we need "required(false)"
  # it { is_expected.to belong_to(:import_queue).required(false) }

  # it { is_expected.to belong_to(:user) }

  it_behaves_like 'for ImportOrders', :import_order

  it { should have_many(:areas) }
  it { should have_many(:artist_credits) }
  it { should have_many(:artists) }
  it { should have_many(:release_heads) }
  it { should have_many(:release_tracks) }
  it { should have_many(:releases) }
  it { should have_many(:medium_formats) }
  it { should have_many(:piece_heads) }
  it { should have_many(:pieces) }

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
        FactoryBot.build(
          :import_order,
          import_queue: ImportQueue.new(name: 'fake_import_queue'),
          type:         'FakeImportOrder'
        )
      end

      it 'publishes the pending ImportOrder' do
        redis = object_double('REDIS', publish: nil).as_stubbed_const
        import_order.save
        expect(redis).to have_received(:publish)
          .with('fake_import_queue', 'run')
      end
    end

    context 'when not pending' do
      let(:import_order) do
        FactoryBot.build(
          :import_order,
          type:  'FakeImportOrder',
          state: :running
        )
      end

      it 'does not publish the ImportOrder' do
        redis = object_double('REDIS', publish: nil).as_stubbed_const
        allow(import_order).to receive(:default_import_queue_name)
          .and_return('fake')
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

  describe '#uri' do
    context 'with only an uri' do
      def code
        '88c27b7d-83e3-4568-8724-fafbee54f05a'
      end

      let(:import_order) do
        uri = "https://musicbrainz.org/ws/2/release/#{code}/"
        ImportOrder.create(uri: uri, user: FactoryBot.create(:user))
      end

      it 'sets the expected code' do
        expect(import_order.code).to eq(code)
      end

      it 'sets the expected type' do
        expect(import_order.type).to eq('BrainzReleaseImportOrder')
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
