# frozen_string_literal: true

require 'rails_helper'
require 'shared_examples_for_services'

RSpec.describe PrepareBrainzRelease do
  it_behaves_like 'a service'

  describe '.call' do
    context 'when the release is not already persisted' do
      let(:import_request) do
        FactoryBot.build(
          :brainz_release_import_request,
          code: '7452f8c9-f9bc-3ca7-859e-3220e57e4e4a'
        )
      end

      it 'returns nil' do
        proxy = spy
        args = { import_request: import_request, proxy: proxy }
        expect(described_class.call(args)).to be_nil
      end
    end
  end
end
