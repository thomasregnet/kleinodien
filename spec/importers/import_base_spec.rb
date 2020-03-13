# frozen_string_literal: true

require 'fake_proxy'
require 'mock_import_order'
require 'rails_helper'
require 'shared_examples_for_services'

RSpec.describe ImportBase do
  it_behaves_like 'a service'

  context 'with an invalid ImportOrder' do
    it 'raises an ArgumentError' do
      import_order = instance_double('ImportOrder')
      allow(import_order).to receive('valid?').and_return(false)

      expect { described_class.call(import_order: import_order) }
        .to raise_error(ArgumentError)
    end
  end

  describe '#call' do
    let(:base) { described_class.new(import_order: MockImportOrder.new) }
    let(:result) { Object.new }

    context 'when successful' do
      before do
        preparer = class_double('PrepareImportService')
                   .as_stubbed_const(transfer_nested_constants: true)
        persister = class_double('PersistImportService')
                    .as_stubbed_const(transfer_nested_constants: true)

        allow(preparer).to receive(:call).and_return(true)
        allow(persister).to receive(:call).and_return(result)

        allow(base).to receive(:find_existing).and_return(nil)
        base.define_singleton_method(:blueprint) { :fake_blueprint }
        base.define_singleton_method(:proxy) { :fake_proxy }
      end

      it 'returns the imported entity' do
        expect(base.call).to eq(result)
      end

      it 'enhances the result' do
        expect(base.call).to be_created
      end
    end

    context 'when the entity can be found by code' do
      before do
        base.define_singleton_method(:find_existing_by_import_order) do
          Object.new
        end
      end

      it 'returns the entity' do
        expect(base.call).not_to be_falsy
      end

      it 'enhances the result' do
        expect(base.call).not_to be_created
      end
    end

    context 'when the entity can be found by blueprint' do
      before do
        base.define_singleton_method(:find_existing_by_import_order) { nil }
        base.define_singleton_method(:find_existing_by_blueprint) do
          Object.new
        end
      end

      it 'returns the entity' do
        expect(base.call).not_to be_falsy
      end

      it 'enhances the result' do
        expect(base.call).not_to be_created
      end
    end
  end

  describe '#enhance_result' do
    let(:base) { described_class.new(import_order: :fake) }
    let(:object) { Object.new }

    context 'with "true" as second parameter' do
      before { base.send(:enhance_result, object, true) }

      it 'creates an "created?" mehthod that returns true' do
        expect(object).to be_created
      end
    end

    context 'with "false" as second parameter' do
      before { base.send(:enhance_result, object, false) }

      it 'creates an "created?" mehthod that returns true' do
        expect(object).not_to be_created
      end
    end
  end
end
