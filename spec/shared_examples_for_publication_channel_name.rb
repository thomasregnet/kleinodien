# frozen_string_literal: true

RSpec.shared_examples 'for #publication_channel_name' do |factory, queue_name|
  describe '.publication_channel_name' do
    it 'returns the queue name' do
      expect(described_class.publication_channel_name).to eq(queue_name)
    end
  end

  describe '#publication_channel_name' do
    let(:model) { FactoryBot.build(factory) }

    it 'returns the queue name' do
      expect(model.publication_channel_name).to eq(queue_name)
    end
  end
end
