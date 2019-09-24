# frozen_string_literal: true

require 'rails_helper'
require 'shared_examples_for_services'

class FakeProxy
  def lock; end
end
class ImportFake < ImportBase
  def find_already_existing; end
  def prepare; end
  def proxy
    @proxy ||= FakeProxy.new
  end
end

class FakeImportOrder < ImportOrder
#  include ImportStateTransitions
end

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

  describe 'when the import transaction fails' do
    let(:import_order) { FakeImportOrder.new }

    it 'raises an error' do
      expect { ImportFake.call(import_order: import_order) }
        .to raise_error(ArgumentError, 'invalid ImportOrder')
    end
  end
end
