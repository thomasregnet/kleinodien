RSpec.shared_examples 'an import params service' do
  context 'with a valid uri' do
    let(:result) { described_class.call(uri) }

    it 'returns the expected code' do
      expect(result[:code]).to eq expected_code
    end

    it 'returns the expected kind' do
      expect(result[:kind]).to eq expected_kind
    end
  end
end
