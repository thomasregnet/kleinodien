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

  context 'when prepare fails' do
    let(:import_base) do
      import_order = FactoryBot.create(:import_order, type: 'FakeImportOrder')
      BadImportFake.new(import_order: import_order)
    end

    it 'sets the ImportOrder#state to "failed"' do
      import_base.send(:try_prepare)
      expect(import_base.import_order.failed?).to be(true)
    end
  end

  context 'when the import transaction fails' do
    let(:import_base) do
      import_order = FactoryBot.create(:import_order, type: 'FakeImportOrder')
      ImportFake.new(import_order: import_order)
    end

    it 'returns nil' do
      expect(import_base.send(:persist)).to be_nil
    end

    it 'sets the ImportOrder#state to "failed' do
      import_base.send(:persist)
      expect(import_base.import_order.failed?).to be(true)
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
