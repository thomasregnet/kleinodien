# frozen_string_literal: true

require 'rails_helper'
require 'shared_examples_for_services'

RSpec.describe ImportCoverArtRelease do
  it_behaves_like 'a service'

  it 'foos' do
    import_order = FactoryBot.create(
      :cover_art_release_import_order,
      code: '58e6a3d6-bbbd-4864-983b-e468a5a1a71c'
    )
   
    FactoryBot.create(:release, brainz_code: '58e6a3d6-bbbd-4864-983b-e468a5a1a71c')

    described_class.call(import_order: import_order)
  end
end