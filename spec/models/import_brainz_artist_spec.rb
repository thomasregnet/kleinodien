require "rails_helper"

RSpec.describe ImportBrainzArtist do
  def jello_biafra_id
    '2280ca0e-6968-4349-8c36-cb0cbd6ee95f'
  end

  specify '#perform' do
    artist_imprter = ImportBrainzArtist.new(jello_biafra_id, ImportCache.new)
    artist_imprter.perform
    expect(artist_imprter.cache.any_required?).to be true
  end
end
