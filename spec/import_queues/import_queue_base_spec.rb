# frozen_string_literal: true

require 'rails_helper'

# Just for testing
class MockImportQueue < ImportQueueBase
  name :test
end

# rubocop:disable Metrics/BlockLength
RSpec.describe ImportQueueBase do
  let(:queue) { MockImportQueue.new }

  describe '#channel' do
    context 'when the connnection is started' do
      it 'returns an instance of Bunny::Channel' do
        queue.connection.start
        expect(queue.channel).to be_instance_of(Bunny::Channel)
      end
    end

    context 'when teh connection is not started' do
      it 'raises a FooBar exception' do
        expect { queue.channel }
          .to raise_error(RuntimeError, /this connection is not open/)
      end
    end
  end

  describe '#connection' do
    it 'returns an instance of Bunny::Session' do
      expect(queue.connection).to be_instance_of(Bunny::Session)
    end
  end

  describe '#exchange' do
    context 'when the connnection is started' do
      it 'returns an instance of Bunny::Exchange' do
        queue.connection.start
        expect(queue.exchange).to be_instance_of(Bunny::Exchange)
      end

      it 'returns a fanout exchange' do
        queue.connection.start
        expect(queue.exchange.type).to eq(:fanout)
      end
    end

    context 'when teh connection is not started' do
      it 'raises a FooBar exception' do
        expect { queue.exchange }
          .to raise_error(RuntimeError, /this connection is not open/)
      end
    end
  end

  describe '#name' do
    it 'returns the name' do
      expect(queue.name).to eq('test')
    end
  end
end
# rubocop:enable Metrics/BlockLength
