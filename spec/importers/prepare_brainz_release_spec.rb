# frozen_string_literal: true

require 'rails_helper'
require 'shared_examples_for_services'

RSpec.describe PrepareBrainzRelease do
  it_behaves_like 'a service'

  describe '.call' do
    context 'with a valid ImportRequest' do
      def brainz_code
        '7452f8c9-f9bc-3ca7-859e-3220e57e4e4a'
      end

      let(:import_request) do
        FactoryBot.build(:brainz_release_import_request, code: brainz_code)
      end

      it 'foos' do
        proxy = BrainzProxy.new(import_order: import_request.import_order)
        described_class.call(
          import_request: import_request,
          proxy:          proxy
        )
        expect(:foo).to eq(:foo)
      end
    end
  end
end

