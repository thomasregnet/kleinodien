# frozen_string_literal: true

RSpec.shared_examples 'for #import_queue_name' do |factory, queue_name|
  describe '.import_queue_name' do
    it 'returns the queue name' do
      expect(described_class.import_queue_name).to eq(queue_name)
    end
  end

  describe '#import_queue_name' do
    let(:model) { FactoryBot.build(factory) }

    it 'returns the queue name' do
      expect(model.import_queue_name).to eq(queue_name)
    end
  end
end
