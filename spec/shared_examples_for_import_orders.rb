# frozen_string_literal: true

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

  context 'without a user' do
    let(:import_order) { FactoryBot.build(model, user: nil) }

    it 'is not valid' do
      expect(import_order).not_to be_valid
    end
  end
end

