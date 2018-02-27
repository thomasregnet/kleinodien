require 'rails_helper'

RSpec.describe Fetcher::Conventions do
  describe '.message_queue_name_for' do
    it 'returns the message queue name' do
      expect(described_class.message_queue_name_for('some_name'))
        .to eq('some_name:messages')
    end
  end
end
