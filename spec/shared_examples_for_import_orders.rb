# frozen_string_literal: true

require 'aasm/rspec'

# rubocop:disable Metrics/BlockLength
RSpec.shared_examples 'for ImportOrders' do |model|
  describe '#active?' do
    context 'when in pending state' do
      let(:import_order) { FactoryBot.build(model, state: :pending) }

      it 'is active' do
        expect(import_order).to be_active
      end
    end

    context 'when in preparing state' do
      let(:import_order) { FactoryBot.build(model, state: :preparing) }

      it 'is active' do
        expect(import_order).to be_active
      end
    end

    context 'when in persisting state' do
      let(:import_order) { FactoryBot.build(model, state: :persisting) }

      it 'is active' do
        expect(import_order).to be_active
      end
    end

    context 'when in done state' do
      let(:import_order) { FactoryBot.build(model, state: :done) }

      it 'is active' do
        expect(import_order).not_to be_active
      end
    end

    context 'when in failed state' do
      let(:import_order) { FactoryBot.build(model, state: :failed) }

      it 'is active' do
        expect(import_order).not_to be_active
      end
    end
  end

  context 'with valid parameters' do
    let(:import_order) { FactoryBot.build(model) }

    it 'is valid' do
      expect(import_order).to be_valid
    end
  end

  context 'without a code' do
    let(:import_order) { FactoryBot.build(model, code: nil) }

    it 'is not valid' do
      expect(import_order).not_to be_valid
    end
  end

  describe '#state' do
    context 'when pending, preparing, persisting, done, failed' do
      let(:import_order) { FactoryBot.build(model) }
      let(:valid_states) { %w[pending preparing persisting done failed] }

      it 'is valid' do
        expect(import_order)
          .to validate_inclusion_of(:state).in_array(valid_states)
      end
    end

    context 'with an invalid value' do
      let(:import_order) { FactoryBot.build(model, state: 'invalid') }

      it 'is not valid' do
        expect(import_order).not_to be_valid
      end
    end

    context 'when nil' do
      let(:import_order) { FactoryBot.build(model, state: nil) }

      it 'is not valid' do
        expect(import_order).not_to be_valid
      end
    end
  end

  describe 'state transitions' do
    let(:import_order) { FactoryBot.create(model) }

    context 'when pending' do
      it 'transits to :preparing' do
        expect(import_order)
          .to transition_from(:pending).to(:preparing).on_event(:prepare)
      end
    end

    context 'when preparing' do
      let(:import_order) do
        FactoryBot.create(model, state: :preparing)
      end

      it 'transits to persisting' do
        expect(import_order)
          .to transition_from(:preparing).to(:persisting).on_event(:persist)
      end
    end

    context 'when persisting' do
      let(:import_order) do
        FactoryBot.create(model, state: :preparing)
      end

      it 'transits to done' do
        expect(import_order)
          .to transition_from(:persisting).to(:done).on_event(:done)
      end
    end
  end

  context 'without a user' do
    let(:import_order) { FactoryBot.build(model, user: nil) }

    it 'is not valid' do
      expect(import_order).not_to be_valid
    end
  end
end
# rubocop:enable Metrics/BlockLength
