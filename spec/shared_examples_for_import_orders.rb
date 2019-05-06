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

  context 'without a kind' do
    let(:import_order) { FactoryBot.build(model, kind: nil) }

    it 'is not valid' do
      expect(import_order).not_to be_valid
    end
  end

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

  describe 'state transitions' do
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
