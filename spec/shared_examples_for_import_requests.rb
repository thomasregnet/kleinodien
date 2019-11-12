# frozen_string_literal: true

require 'aasm/rspec'

# rubocop:disable Metrics/BlockLength
RSpec.shared_examples 'for ImportRequests' do |model|
  context 'with valid parameters' do
    let(:import_request) { FactoryBot.build(model) }

    it 'is valid' do
      expect(import_request).to be_valid
    end
  end

  context 'without a code' do
    let(:import_request) { FactoryBot.build(model, code: nil) }

    it 'is not valid' do
      expect(import_request).not_to be_valid
    end
  end

  describe '#state' do
    context 'when pending' do
      let(:import_request) { FactoryBot.build(model, state: :pending) }

      it 'is valid' do
        expect(import_request).to be_valid
      end
    end

    context 'when running' do
      let(:import_request) { FactoryBot.build(model, state: :running) }

      it 'is valid' do
        expect(import_request).to be_valid
      end
    end

    context 'when done' do
      let(:import_request) { FactoryBot.build(model, state: :done) }

      it 'is valid' do
        expect(import_request).to be_valid
      end
    end

    context 'when failed' do
      let(:import_request) { FactoryBot.build(model, state: :failed) }

      it 'is valid' do
        expect(import_request).to be_valid
      end
    end

    context 'when wrong' do
      let(:import_request) { FactoryBot.build(model, state: :wrong) }

      it 'is not valid' do
        expect(import_request).not_to be_valid
      end
    end
  end

  describe 'context transitions' do
    context 'when pending' do
      let(:import_order) { FactoryBot.create(model) }

      it 'transits to running' do
        expect(import_order)
          .to transition_from(:pending).to(:running).on_event(:run)
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

    context 'when running' do
      let(:import_order) { FactoryBot.create(model, state: :running) }

      it 'transits to done' do
        expect(import_order)
          .to transition_from(:running).to(:done).on_event(:done)
      end

      it 'transits to failed' do
        expect(import_order)
          .to transition_from(:running).to(:failed).on_event(:failure)
      end

      it 'does not transit to pending' do
        expect(import_order).not_to allow_event(:pending)
      end
    end

    context 'when done' do
      let(:import_order) { FactoryBot.create(model, state: :done) }

      it 'does not transit to pending' do
        expect(import_order).not_to allow_event(:pending)
      end

      it 'does not transit to running' do
        expect(import_order).not_to allow_event(:running)
      end

      it 'does not transit to failed' do
        expect(import_order).not_to allow_event(:failed)
      end
    end

    context 'when failed' do
      let(:import_order) { FactoryBot.create(model, state: :failed) }

      it 'does not transit to pending' do
        expect(import_order).not_to allow_event(:pending)
      end

      it 'does not transit to running' do
        expect(import_order).not_to allow_event(:running)
      end

      it 'does not transit to done' do
        expect(import_order).not_to allow_event(:done)
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
