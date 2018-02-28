require 'rails_helper'

RSpec.describe Fetcher::Queue do
  # TODO: run useful tests as the Fetcher::Queue does something
  describe '.perform' do
    it 'responds to' do
      expect(described_class).to respond_to(:perform)
    end
  end
end
