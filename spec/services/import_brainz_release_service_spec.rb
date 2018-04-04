# frozen_string_literal: true

require 'rails_helper'
require 'shared_examples_for_services'

RSpec.describe ImportBrainzReleaseService do
  it_behaves_like 'a service'

  context 'when nothing is cached' do
    let(:args) do
      {
        code:          '7452f8c9-f9bc-3ca7-859e-3220e57e4e4a',
        importer_name: 'test'
      }
    end

    it 'returns false' do
      expect(described_class.call(args)).to be false
    end
  end
end
