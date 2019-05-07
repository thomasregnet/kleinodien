# frozen_string_literal: true

require 'aasm/rspec'

# rubocop:disable Metrics/BlockLength
RSpec.shared_examples 'an import state transitions capable object' do |factory|
  context 'when pending' do
    let(:import_order) { FactoryBot.create(factory) }

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
    let(:import_order) { FactoryBot.create(factory, state: :processing) }

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
    let(:import_order) { FactoryBot.create(factory, state: :done) }

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
    let(:import_order) { FactoryBot.create(factory, state: :failed) }

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
# rubocop:enable Metrics/BlockLength
