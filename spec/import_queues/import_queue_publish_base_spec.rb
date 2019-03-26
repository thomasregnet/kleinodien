# frozen_string_literal: true

require 'rails_helper'

# Just for testing
class FakeImpotQueuePublishBase < ImportQueuePublishBase
  name :fake_import_queue
end

RSpec.describe ImportQueuePublishBase do
  describe '#call' do
    let(:publisher) { described_class.new('my message') }

    it 'publishes the message' do
      
    end
  end
end
