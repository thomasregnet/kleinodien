# frozen_string_literal: true

require 'rails_helper'
require 'shared_examples_for_services'

# This class must be defined. Otherwise :call can't be called on
# the constantized class.
class ImportStuffForTesting
  def self.call(import_order:)
    @import_order = import_order
  end
end

# rubocop:disable Metrics/BlockLength
RSpec.describe ImporterChooser do
  it_behaves_like 'a service'

  describe '.call' do
    context 'with a valid ImportOrder' do
      let(:import_order) { spy }

      it 'calls the right importer' do
        importer = class_double('ImportSomeStuff')
                   .as_stubbed_const(transfer_nested_constants: true)

        allow(import_order).to receive(:type)
          .and_return('ImportStuffForTesting')

        allow(importer).to receive(:call)
          .with(import_order: import_order)

        expect(described_class.call(import_order: import_order))
          .to eq(import_order)
      end
    end

    context 'with an invalid ImportOrder' do
      let(:import_order) { spy }

      it 'calls the right importer' do
        importer = class_double('ImportSomeStuff')
                   .as_stubbed_const(transfer_nested_constants: true)

        allow(import_order).to receive(:type)
          .and_return('UnuseableString')

        allow(importer).to receive(:call)
          .with(import_order: import_order)

        expect { described_class.call(import_order: import_order) }
          .to raise_error(NameError, /uninitialized constant/)
      end
    end

    context 'with ImportOrder#type nil' do
      let(:import_order) { spy }

      it 'calls the right importer' do
        importer = class_double('ImportSomeStuff')
                   .as_stubbed_const(transfer_nested_constants: true)

        allow(import_order).to receive(:type)
          .and_return(nil)

        allow(importer).to receive(:call)
          .with(import_order: import_order)

        expect { described_class.call(import_order: import_order) }
          .to raise_error(NoMethodError, /undefined method/)
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
