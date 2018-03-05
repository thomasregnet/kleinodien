# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Import::Queue::Conventions do
  let(:conventions) { described_class.new }

  describe 'key_name_for' do
    let(:uri) { 'https://example.com' }

    context 'when called as class method' do
      it 'returns the key name' do
        expect(described_class.key_name_for(uri))
          .to eq('data:https://example.com')
      end
    end

    context 'when called as instance method' do
      it 'returns the key name' do
        expect(conventions.key_name_for(uri))
          .to eq('data:https://example.com')
      end
    end
  end

  describe '.message_queue_name_for' do
    it 'returns the message queue name' do
      expect(described_class.message_queue_name_for('test'))
        .to eq('test:messages')
    end
  end

  describe '#message_queue_name' do
    context 'with fetcher_name initialized' do
      let(:conventions) { described_class.new(fetcher_name: 'test') }

      it 'returns the queue_name' do
        expect(conventions.message_queue_name).to eq('test:messages')
      end
    end

    context 'without fetcher_name initialized' do
      it 'raises an error' do
        expect { conventions.message_queue_name }
          .to raise_error(RuntimeError)
      end
    end
  end
end
