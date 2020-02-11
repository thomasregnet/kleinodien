# frozen_string_literal: true

require 'rails_helper'

RSpec.describe InitImportWorker do
  describe '.call' do
    before { ENV['IMPORT_QUEUE_NAME'] = 'test_import_queue' }

    it 'calls .run on ImportWorker' do
      allow(ImportWorker).to receive(:run).with(
        hash_including(
          import_queue_name:    'test_import_queue',
          subscription_timeout: 300
        )
      ).and_return(:success)
      expect(described_class.call).to eq(:success)
    end
  end

  describe '.new' do
    context 'when the environment variable IMPORT_QUEUE_NAME is set' do
      let(:import_queue_name) { 'test_import_queue' }

      before { ENV['IMPORT_QUEUE_NAME'] = import_queue_name }

      it 'sets the instance variable "import_queue_name"' do
        expect(described_class.new.import_queue_name).to eq(import_queue_name)
      end

      it 'sets the default timeout' do
        expect(described_class.new.timeout).to eq(300)
      end
    end

    context 'with the environment variable IMPORT_SUBSCRIPTION_TIMEOUT set' do
      let(:timeout) { '123' } # must be a string

      before do
        ENV['IMPORT_SUBSCRIPTION_TIMEOUT'] = timeout
        ENV['IMPORT_QUEUE_NAME']           = 'test_queue_name'
      end

      it 'sets the instance_variable timeout as an integer' do
        expect(described_class.new.timeout).to eq(timeout.to_i)
      end
    end

    context 'when the environment variable IMPORT_QUEUE_NAME is not set' do
      before { ENV.delete('IMPORT_QUEUE_NAME') }

      it 'returns the environment variable' do
        expect { described_class.new }
          .to raise_error ArgumentError, /IMPORT_QUEUE_NAME not set/
      end
    end
  end
end
