# frozen_string_literal: true

RSpec.shared_examples 'a test-data result' do |raw_data, blueprint_class|
  def string
    'a test string'
  end

  let(:result) { described_class.new(string) }

  describe '#raw' do
    it 'returns the given string' do
      expect(result.raw).to eq string
    end
  end

  describe '#to_s' do
    it 'returns the raw string' do
      expect(result.to_s).to eq string
    end
  end

  describe '#blueprint' do
    let(:result) { described_class.new(raw_data) }

    it 'returns a blueprint of the expected class' do
      expect(result.blueprint).to be_instance_of(blueprint_class)
    end
  end
end
