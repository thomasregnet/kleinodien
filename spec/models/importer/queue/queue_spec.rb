require 'rails_helper'

RSpec.describe Importer::Queue::Queue do
  # TODO: run useful tests as the Importer::Queue::Queue does something
  describe '.perform' do
    it 'responds to' do
      expect(described_class).to respond_to(:perform)
    end
  end
end
