# frozen_string_literal: true

require 'rails_helper'
require 'shared_examples_for_services'

# rubocop:disable Metrics/BlockLength
# rubocop:disable RSpec/VerifiedDoubles
RSpec.describe CodesForModelService do
  it_behaves_like 'a service'

  describe '.call' do
    context 'without "given"' do
      let(:model_class) do
        double(column_names: %i[known_code some_column])
      end

      let(:codes_hash) do
        described_class.call(
          codes_hash:  { known_code: 'known', unknown_code: 2 },
          model_class: model_class
        )
      end

      it 'returns a HashWithIndifferentAccess' do
        expect(codes_hash)
          .to be_instance_of(ActiveSupport::HashWithIndifferentAccess)
      end

      it 'has the exepcted lenth' do
        expect(codes_hash.length).to eq(1)
      end

      it 'returns the expected keys' do
        expect(codes_hash[:known_code]).to eq('known')
      end
    end

    context 'with given' do
      let(:model_class) do
        double(column_names: %i[known_code some_column])
      end

      let(:codes_hash) do
        described_class.call(
          codes_hash:  { known_code: 'known', unknown_code: 2 },
          given:       { given_parameter: 'given' },
          model_class: model_class
        )
      end

      it 'returns a HashWithIndifferentAccess' do
        expect(codes_hash)
          .to be_instance_of(ActiveSupport::HashWithIndifferentAccess)
      end

      it 'has the exepcted lenth' do
        expect(codes_hash.length).to eq(2)
      end

      it 'contains the given parameter' do
        expect(codes_hash[:given_parameter]).to eq('given')
      end
    end
  end
end
# rubocop:enable RSpec/VerifiedDoubles
# rubocop:enable Metrics/BlockLength
