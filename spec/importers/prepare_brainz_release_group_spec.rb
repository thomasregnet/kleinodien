# frozen_string_literal: true

require 'rails_helper'
require 'test_data'
require 'shared_examples_for_services'

# rubocop:disable Metrics/BlockLength
RSpec.describe PrepareBrainzReleaseGroup do
  it_behaves_like 'a service'

  context 'when the ReleaseHead does not exist' do
    let(:import_request) do
      FactoryBot.create(:brainz_release_group_import_request)
    end
    let(:blueprint) do
      TestData.by_name(:brainz_release_the_sky_is_falling_gb_cd)
              .blueprint
              .release_group
    end
    let(:proxy) { instance_double('BrainzProxy') }
    let(:preparer) do
      described_class.new(
        import_order:   :fake_import_order,
        import_request: import_request,
        proxy:          proxy
      )
    end

    before do
      allow(proxy).to receive(:get)
        .with(import_request)
        .and_return(blueprint)
    end

    it 'calls #prepare_artist_credit' do
      expect(preparer).to receive(:prepare_artist_credit)
      preparer.prepare
    end
  end
end
# rubocop:enable Metrics/BlockLength
