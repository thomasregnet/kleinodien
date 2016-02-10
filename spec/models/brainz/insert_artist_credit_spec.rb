require 'rails_helper'
require 'brainz_test_helper'

RSpec.describe Brainz::InsertArtistCredit, type: :model do
  context 'AC/DC - Highway to Hell' do
    before(:all) do
      DatabaseCleaner.start
      brz_release = BrainzTestHelper
                    .get_release('c8f7094d-ce27-365e-961f-0af27321be08')
      @artist_credit = Brainz::InsertArtistCredit
                       .perform(brz_release.artist_credit)
    end

    specify '#name' do
      expect(@artist_credit.name).to eq 'AC/DC'
    end

    after(:all) { DatabaseCleaner.clean }
  end
end
