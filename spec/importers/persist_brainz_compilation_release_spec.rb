# frozen_string_literal: true

require 'rails_helper'
require 'shared_examples_for_services'
require 'test_data'

# rubocop:disable Metrics/BlockLength
RSpec.describe PersistBrainzCompilationRelease do
  it_behaves_like 'a service'

  describe '.call' do
    context 'when the CompilationRelease already exists' do
      def brainz_code
        '693748be-7c18-39c3-af2e-2e62092090cf'
      end

      before do
        FactoryBot.create(
          :compilation_release,
          brainz_code: brainz_code, # '693748be-7c18-39c3-af2e-2e62092090cf',
          title:       'Test Dummy'
        )
      end

      let(:blueprint) do
        TestData.by_name(:brainz_release_the_sky_is_falling_gb_cd).blueprint
      end

      let(:import_request) do
        BrainzReleaseGroupImportRequest.new(code: brainz_code)
      end

      it 'returns the CompilationRelease' do
        proxy = spy
        allow(proxy).to receive(:get).and_return(blueprint)
        args = { import_request: import_request, proxy: proxy }
        expect(described_class.call(args).title).to eq('Test Dummy')
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
