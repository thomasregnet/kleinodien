# frozen_string_literal: true

require 'fake_proxy'
require 'rails_helper'
require 'shared_examples_for_services'

# For testing
class ImportFake < ImportBase
  def find_already_existing; end

  def prepare; end

  def proxy
    @proxy ||= FakeProxy.new
  end

  def find_existing_by_blueprint; end

  def find_existing_by_import_order; end
end

# For testing
class FakeImportOrder < ImportOrder
end

# For testing
class PersistFake < PersistBase
  def call
    raise StandardError, 'Test exception'
  end
end

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
