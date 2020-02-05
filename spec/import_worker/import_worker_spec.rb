# frozen_string_literal: true

require 'rails_helper'

# rubocop:disable Metrics/BlockLength
RSpec.describe ImportWorker do
  describe '#run' do
    let(:subscriber) { instance_double('ImportSubscriber') }
    let(:worker) do
      described_class.new(
        import_queue_name: 'my_queue',
        subscriber:        subscriber
      )
    end

    it 'stops when it receives a "stop" message' do
      allow(subscriber).to receive(:perform).and_return('run', 'stop')
      expect(worker.run).to be_nil
    end
  end

  # https://www.rubydoc.info/gems/rubocop-rspec/1.6.0/RuboCop/Cop/RSpec/AnyInstance
  describe '.run' do
    context 'with valid parameters' do
      let(:subscriber) { instance_double('ImportSubscriber') }
      let(:args) do
        {
          import_queue_name: 'my_queue',
          subscriber:        subscriber
        }
      end
      let(:worker) { instance_double(described_class) }

      before do
        allow(described_class).to receive(:new).and_return(worker)
        allow(worker).to receive(:run).and_return('run called')
      end

      it 'calls #run' do
        expect(described_class.run(args)).to eq('run called')
      end
    end

    context 'with a blank import_queue_name' do
      let(:subscriber) { instance_double('ImportSubscriber') }
      let(:args) do
        {
          import_queue_name: '',
          subscriber:        subscriber
        }
      end

      # the regex ("can.t be blank")uses an dot instead of an
      # apostrophe because the apostrophe confuses emacs
      it 'raises an ArgumentError' do
        expect { described_class.run(args) }
          .to raise_error(ArgumentError, /can.t be blank/)
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
