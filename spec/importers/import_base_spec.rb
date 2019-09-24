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
  # include ImportStateTransitions

  # def running?
  #   false
  # end

  # def failure!
  # end
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

  context 'when the import transaction fails' do
    let(:import_order) do
      FactoryBot.create(:import_order, type: 'FakeImportOrder')
    end

    it 'does not return a result' do
      ImportFake.call(import_order: import_order)
      expect(import_order.failed?).to be(true)
    end

    it 'returns nil' do
      result = ImportFake.call(import_order: import_order)
      expect(result).to be_nil
    end
  end
end
