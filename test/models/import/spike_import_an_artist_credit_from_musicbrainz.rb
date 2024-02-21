require "test_helper"
require "support/web_mock_external_apis"

class Import::SpikeImportAnArtistCreditFromMusicbrainzTest < ActiveSupport::TestCase
  setup do
    WebMockExternalApis.setup

    @session = Import::Session.new(:fake_import_order)

    @artist_credit = @session
      .musicbrainz
      .get(:release, "36ddebf6-7fb2-4dc4-8931-aca5a3a35a30")
      .artist_credit
    @presenter = Import::MusicbrainzArtistCreditPresenter.new(@session, data: @artist_credit)
    @aquirer = Import::Aquirer.new(@presenter)
  end

  test "import an ArtistCredit" do
    persisted_artist_credit = @aquirer.aquire

    # debugger
    assert_equal persisted_artist_credit.name, "Jello Biafra With NoMeansNo"
  end
end
