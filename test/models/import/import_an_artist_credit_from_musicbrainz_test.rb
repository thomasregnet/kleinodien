require "test_helper"
require "support/web_mock_external_apis"

class Import::ImportAnArtistCreditFromMusicbrainzTest < ActiveSupport::TestCase
  setup do
    WebMockExternalApis.setup

    @session = Import::Session.new(:fake_import_order, default_factory: :musicbrainz)

    @artist_credit = @session
      .musicbrainz
      .get(:release, "36ddebf6-7fb2-4dc4-8931-aca5a3a35a30")
      .artist_credit
    @facade = @session.build_facade(data: @artist_credit, model: ArtistCredit)

    @handler = Import::Handler.new(@facade)
  end

  test "import an ArtistCredit" do
    persisted_artist_credit = @handler.call

    assert_equal persisted_artist_credit.name, "Jello Biafra With NoMeansNo"
    # assert_equal persisted_artist_credit.participants.first.name, "Jello Biafra"
  end
end