# frozen_string_literal: true

require 'rails_helper'
require 'redis_helper'
require 'shared_examples_for_services'

RSpec.describe PrepareBrainzReleaseService do
  it_behaves_like 'a service'

  before { DatabaseCleaner.start }

  let(:args) do
    {
      code:          '7452f8c9-f9bc-3ca7-859e-3220e57e4e4a',
      importer_name: 'test'
    }
  end

  context 'when nothing is cached' do
    it 'returns nil' do
      expect(described_class.call(args)).to be_nil
    end
  end

  after { DatabaseCleaner.clean }
end
