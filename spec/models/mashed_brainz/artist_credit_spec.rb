require 'rails_helper'
require 'brainz_test_helper'

RSpec.describe MashedBrainz::ArtistCredit, type: :model do
  context 'Butcherd at Birth' do
    before(:each) do
      @release = BrainzTestHelper.get_mashed_brainz(
        :release,
        '28e723f2-1c0a-38a0-8109-038cca05ffca'
      )
      @artist_credit = @release.artist_credit
    end

    specify '#artist_credit' do
      expect(@artist_credit.name_credit)
        .to be_instance_of Hashie::Array
    end
  end

  context 'The Sky is Falling and I Want My Mommy' do
    before(:each) do
      @release = BrainzTestHelper.get_mashed_brainz(
        :release,
        '693748be-7c18-39c3-af2e-2e62092090cf'
      )
      @artist_credit = @release.artist_credit
    end

    specify '#artist_credit' do
      expect(@artist_credit.name_credit)
        .to be_kind_of Hashie::Array
    end
  end
end
