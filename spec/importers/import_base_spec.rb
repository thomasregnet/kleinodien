# frozen_string_literal: true

require 'rails_helper'
require 'shared_examples_for_services'

# For testing
class FakeProxy
  def lock; end
end

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
class BadImportFake < ImportFake
  def prepare
    raise 'Bad Prepare'
  end
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

  # context 'when prepare fails' do
  #   let(:import_order) do
  #     FactoryBot.create(:import_order, type: 'FakeImportOrder')
  #   end

  #   it 'sets the ImportOrder#state to "failed"' do
  #     BadImportFake.call(import_order: import_order)
  #     expect(import_order.failed?).to be(true)
  #   end

  #   # it 'returns nil' do
  #   #   result = BadImportFake.call(import_order: import_order)
  #   #   expect(result).to be_nil
  #   # end
  # end

  # context 'when the import transaction fails' do
  #   let(:import_order) do
  #     FactoryBot.create(:import_order, type: 'FakeImportOrder')
  #   end

  #   it 'sets the ImportOrder#state to "failed' do
  #     ImportFake.call(import_order: import_order)
  #     expect(import_order.failed?).to be(true)
  #   end

  #   it 'returns nil' do
  #     result = ImportFake.call(import_order: import_order)
  #     expect(result).to be_nil
  #   end
  # end
end
