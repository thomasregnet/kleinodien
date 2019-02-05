# frozen_string_literal: true

RSpec.shared_examples 'a model with duration' do
  describe '#mmss' do
    let(:candidate) { described_class.new }

    it 'returns the duration in mm:ss format' do
      candidate.duration = Duration.new(311_000, 'second')
      expect(candidate.duration.mmss).to eq('5:11')
    end
  end
end
