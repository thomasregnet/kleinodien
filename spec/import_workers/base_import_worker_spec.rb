# frozen_string_literal: true

require 'rails_helper'

# Fake an ImportService for testing
class DummyImporterService
  def self.call(import_order)
    true
  end
end

# Dummy importer for testing
class DummyImporter < ImportOrder; end

RSpec.describe BaseImportWorker do
  describe '.run' do
    # OPTIMIZE: nicer specs for .run
    it 'responds to .run' do
      expect(described_class).to respond_to(:run)
    end
  end

  context 'with a queued ImportOrder' do
    before do
      ImportOrder.create!(
        code: '123',
        kind: 'some-kind',
        state: 'pending',
        type: 'DummyImporter',
        user: FactoryBot.create(:user)
      )
    end

    it 'foo' do
      expect(described_class.run(DummyImporter)).to be true
    end
  end
end
