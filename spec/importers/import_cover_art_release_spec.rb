# frozen_string_literal: true

require 'rails_helper'
require 'shared_examples_for_services'

RSpec.describe ImportCoverArtRelease do
  it_behaves_like 'a service'

  context 'when a front-cover is available' do
    let(:brainz_code) { '58e6a3d6-bbbd-4864-983b-e468a5a1a71c' }
    let(:import_order) { FactoryBot.create(:cover_art_release_import_order, code: brainz_code) }

    before do
      FactoryBot.create(:release, brainz_code: '58e6a3d6-bbbd-4864-983b-e468a5a1a71c')
      described_class.call(import_order: import_order)
    end

    it 'attaches the front-cover to the release' do
      release = Release.find_by(brainz_code: brainz_code)
      expect(release.front_cover).to be_attached
    end
  end
end
