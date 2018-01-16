require 'rails_helper'
require 'ko_test_data'

RSpec.describe Import::PrepareBrainzArtistCredit do
  def code
    '693748be-7c18-39c3-af2e-2e62092090cf'
  end

  def xml
    KoTestData.brainz_release(BrainzReleaseReference.from_code(code))
  end

  def artist_credit
    MashedBrainz.from_xml(xml).artist_credit
  end

  context 'without store' do
    describe '#store.missing?' do
      it 'returns true' do
        ac_preparer = described_class.new(
          template: artist_credit
        )
        ac_preparer.perform
        expect(ac_preparer.store.missing?).to be true
      end
    end
  end
end
