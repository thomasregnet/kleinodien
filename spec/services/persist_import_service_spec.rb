# frozen_string_literal: true

require 'fake_proxy'
require 'mock_import_order'
require 'rails_helper'
require 'shared_examples_for_services'

# for testing
class PersistMock
  def self.call(_)
    raise 'Failed!'
  end
end

RSpec.describe PersistImportService do
  it_behaves_like 'a service'

  context 'when .call to the persisting class fails' do
    let(:import_order) { MockImportOrder.new }
    let(:proxy) { FakeProxy.new }

    before do
      described_class.call(
        blueprint:    :fake_blueprint,
        import_order: import_order,
        proxy:        proxy
      )
    end

    it 'locks the proxy' do
      expect(proxy).to be_locked
    end

    it 'sets the ImportOrder state to "failed"' do
      expect(import_order).to be_failed
    end
  end

  describe '#persister_class' do
    it 'returns the persister-class' do
      service = described_class.new(
        blueprint:    :fake_blueprint,
        import_order: MockImportOrder.new,
        proxy:        :fake_proxy
      )

      expect(service.send(:persister_class)).to eq(PersistMock)
    end
  end
end
