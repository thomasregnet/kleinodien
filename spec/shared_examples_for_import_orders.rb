# frozen_string_literal: true

require 'aasm/rspec'

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

RSpec.shared_examples 'an ImportOrder' do |factory|
  it { should have_many(:areas) }
  it { should have_many(:artist_credits) }
  it { should have_many(:artists) }
  it { should have_many(:companies) }
  it { should have_many(:release_heads) }
  it { should have_many(:release_tracks) }
  it { should have_many(:releases) }
  it { should have_many(:medium_formats) }
  it { should have_many(:piece_heads) }
  it { should have_many(:pieces) }

  describe '.model_name' do
    it 'returns an instance of ActiveModel::Name' do
      expect(described_class.model_name).to be_instance_of(ActiveModel::Name)
    end

    it 'returns an instance which #name id "ImportOrder"' do
      expect(described_class.model_name.name).to eq('ImportOrder')
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
        FactoryBot.create(factory, type: 'FakeImportOrder')
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
        FactoryBot.create(factory, type: 'OtherFakeImportOrder')
      end

      it 'returns that order' do
        expect(FakeImportOrder.next_pending).to be_nil
      end
    end
  end

  describe '#active?' do
    context 'when in pending state' do
      let(:import_order) { FactoryBot.build(factory, state: :pending) }

      it 'is active' do
        expect(import_order).to be_active
      end
    end

    context 'when in preparing state' do
      let(:import_order) { FactoryBot.build(factory, state: :preparing) }

      it 'is active' do
        expect(import_order).to be_active
      end
    end

    context 'when in persisting state' do
      let(:import_order) { FactoryBot.build(factory, state: :persisting) }

      it 'is active' do
        expect(import_order).to be_active
      end
    end

    context 'when in done state' do
      let(:import_order) { FactoryBot.build(factory, state: :done) }

      it 'is not active' do
        expect(import_order).not_to be_active
      end
    end

    context 'when in failed state' do
      let(:import_order) { FactoryBot.build(factory, state: :failed) }

      it 'is not active' do
        expect(import_order).not_to be_active
      end
    end
  end

  context 'with valid parameters' do
    let(:import_order) { FactoryBot.build(factory) }

    it 'is valid' do
      expect(import_order).to be_valid
    end
  end

  context 'without a code' do
    let(:import_order) { FactoryBot.build(factory, code: nil) }

    it 'is not valid' do
      expect(import_order).not_to be_valid
    end
  end

  describe '#state' do
    context 'when pending, preparing, persisting, done, failed' do
      let(:import_order) { FactoryBot.build(factory) }
      let(:valid_states) { %w[pending preparing persisting done failed] }

      it 'is valid' do
        expect(import_order)
          .to validate_inclusion_of(:state).in_array(valid_states)
      end
    end

    context 'with an invalid value' do
      let(:import_order) { FactoryBot.build(factory, state: 'invalid') }

      it 'is not valid' do
        expect(import_order).not_to be_valid
      end
    end

    context 'when nil' do
      let(:import_order) { FactoryBot.build(factory, state: nil) }

      it 'is not valid' do
        expect(import_order).not_to be_valid
      end
    end
  end

  describe 'state transitions' do
    let(:import_order) { FactoryBot.create(factory) }

    context 'when pending' do
      it 'transits to :preparing' do
        expect(import_order)
          .to transition_from(:pending).to(:preparing).on_event(:prepare)
      end
    end

    context 'when preparing' do
      let(:import_order) do
        FactoryBot.create(factory, state: :preparing)
      end

      it 'transits to persisting' do
        expect(import_order)
          .to transition_from(:preparing).to(:persisting).on_event(:persist)
      end
    end

    context 'when persisting' do
      let(:import_order) do
        FactoryBot.create(factory, state: :preparing)
      end

      it 'transits to done' do
        expect(import_order)
          .to transition_from(:persisting).to(:done).on_event(:done)
      end
    end
  end

  context 'without a user' do
    let(:import_order) { FactoryBot.build(factory, user: nil) }

    it 'is not valid' do
      expect(import_order).not_to be_valid
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
