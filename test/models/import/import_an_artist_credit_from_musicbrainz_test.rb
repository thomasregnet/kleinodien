require "test_helper"
require "support/web_mock_external_apis"

class Import::ImportAnArtistCreditFromMusicbrainzTest < ActiveSupport::TestCase
  setup do
    WebMockExternalApis.setup

    @session = Import::MusicbrainzSession.new(:fake_import_order)

    @artist_credit = @session
      .get(:release, "36ddebf6-7fb2-4dc4-8931-aca5a3a35a30")
      .artist_credit
    @facade = @session.build_facade(ArtistCredit, data: @artist_credit)

    @handler = Import::Handler.new(@facade)
  end

  test "import an ArtistCredit" do
    persisted = @handler.call

    assert_equal persisted.name, "Jello Biafra With NoMeansNo"
    assert_equal persisted.participants.first.name, "Jello Biafra"
    assert_not persisted.participants.second.new_record?
  end
end
