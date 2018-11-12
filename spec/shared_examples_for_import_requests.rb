# frozen_string_literal: true

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

    context 'when processing' do
      let(:import_request) { FactoryBot.build(model, state: :processing) }

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
end
