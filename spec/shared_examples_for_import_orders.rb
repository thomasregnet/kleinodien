# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength
RSpec.shared_examples 'for ImportOrders' do |model|
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

  # This test does not work any longer because the ImportQueue
  # is generated automatically
  # context 'without an import_queue' do
  #   let(:import_order) { FactoryBot.build(model, import_queue: nil) }

  #   it 'is not valid' do
  #     expect(import_order).not_to be_valid
  #   end
  # end

  describe '#state' do
    context 'when pending, processing, done, failed' do
      let(:import_order) { FactoryBot.build(model) }
      let(:valid_states) { %w[pending processing done failed] }

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

  context 'without a user' do
    let(:import_order) { FactoryBot.build(model, user: nil) }

    it 'is not valid' do
      expect(import_order).not_to be_valid
    end
  end
end
# rubocop:enable Metrics/BlockLength
