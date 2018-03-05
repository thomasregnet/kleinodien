require 'rails_helper'

RSpec.describe Import::Queue::Queue do
  # TODO: run useful tests as the Import::Queue::Queue does something
  describe '.perform' do
    it 'responds to' do
      expect(described_class).to respond_to(:perform)
    end
  end
end
