# frozen_string_literal: true

RSpec.shared_examples 'an ISO-3166 model' do
  it { should belong_to(:area) }

  context 'with valid arguments' do
    let(:iso) do
      described_class.new(area: FactoryBot.create(:area), code: good_code)
    end

    it 'is valid' do
      expect(iso).to be_valid
    end
  end

  describe '#code' do
    context 'when missing' do
      let(:iso) { described_class.new(area: FactoryBot.create(:area)) }

      it 'is not valid' do
        expect(iso).not_to be_valid
      end
    end

    context 'when blank' do
      let(:iso) do
        described_class.new(area: FactoryBot.create(:area), code: '')
      end

      it 'is not valid' do
        expect(iso).not_to be_valid
      end
    end
  end
end
