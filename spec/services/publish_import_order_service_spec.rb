# frozen_string_literal: true

require 'rails_helper'
require 'shared_examples_for_services'

# rubocop:disable Metrics/BlockLength
RSpec.describe PublishImportOrderService do
 #  it_behaves_like 'a service'

 #  let(:channel) { 'test_channel' }
 #  let(:import_order) { instance_double('ImportOrder') }

 #  before do
 #    redis = Redis.new(host: 'redis')
 #    @thread = Thread.new do
 #      puts "== Thread channel: #{channel}"
 #      redis.subscribe(channel) do |on|
 #        on.message do |_, msg|
 #          puts "=============== #{msg}"
 #          @received_message = msg
 #          redis.unsubscribe
 #        end
 #      end
 #    end

 #    allow(import_order).to receive(:import_queue_name).and_return(channel)
 #  end

 #  # after do
 #  #   @thread.join
 #  # end
 #  let(:message) { 'hello world' }

 # it 'publishes a message' do
 #   _class.call(import_order: import_order, message: message)
 #   puts "============ #{@received_message} ==="
 #   expect(@received_message).to eq(message)
 #  end

  # def channel
  #   @channel ||= connection.create_channel
  # end

  # def connection
  #   # TODO: get RabbitMQ host name via configuration
  #   @connection ||= Bunny.new(host: 'rabbit')
  # end

  # def exchange
  #   @exchange ||= channel.direct('import_orders')
  # end

  # describe '.call' do
  #   let(:import_order) { instance_double('ImportOrder') }
  #   let(:queue) do
  #     channel.queue('', exclusive: true)
  #   end

  #   before do
  #     connection.start
  #     allow(import_order).to receive(:import_queue_name).and_return('my_queue')
  #   end

  #   after do
  #     channel.close
  #     connection.close
  #   end

    # rubocop:disable RSpec/InstanceVariable
    # it 'publishes the ImportOrder' do
    #   queue.bind(exchange, routing_key: 'my_queue')

    #   described_class.call(import_order: import_order)

    #   queue.subscribe do |_delivery_info, _propertise, body|
    #     @received = body
    #   end

    #   expect(@received).to eq('run')
    # end
    # rubocop:enable RSpec/InstanceVariable
#  end
end
# rubocop:enable Metrics/BlockLength
