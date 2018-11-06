# frozen_string_literal: true

require 'rails_helper'

# Fake an ImportService for testing
class DummyImporterService
  def self.call(_import_order)
    true
  end
end

# ImportOrder for testing
class DummyImportOrder < ImportOrder; end

RSpec.describe BaseImportWorker do
  context 'with an appropriate queued ImportOrder' do
    before { DatabaseCleaner.start }

    after { DatabaseCleaner.clean }

    let(:import_order) do
      DummyImportOrder.create!(
        code: '123',
        kind: 'some-kind',
        user: FactoryBot.create(:user)
      )
    end

    let(:args) do
      {
        import_order_class: DummyImportOrder,
        import_service_class: DummyImporterService
      }
    end

    it 'calls .run on the importer service' do
      expect(described_class.run(args)).to be nil
    end
  end
end
