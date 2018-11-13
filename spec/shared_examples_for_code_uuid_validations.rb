# frozen_string_literal: true

RSpec.shared_examples 'for code fields that must be an uuid' do |model|
  # let(:model) { described_class }

  describe '#code' do
    context 'with an uuid' do
      let(:candidate) { FactoryBot.build(model, code: SecureRandom.uuid.to_s) }

      it 'is valid' do
        expect(candidate).to be_valid
      end
    end

    context 'with a wrong value' do
      let(:candidate) { FactoryBot.build(model, code: 'not-a-uuid') }

      it 'is not valid' do
        expect(candidate).not_to be_valid
      end
    end
  end
end
