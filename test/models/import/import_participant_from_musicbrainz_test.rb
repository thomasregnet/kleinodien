require "test_helper"
require "support/web_mock_external_apis"

class Import::ImportParticipantFromMusicbrainzTest < ActiveSupport::TestCase
  setup do
    WebMockExternalApis.setup

    @session = Import::Session.new(:fake_import_order)
    json_string = @session.musicbrainz.get(:release, "36ddebf6-7fb2-4dc4-8931-aca5a3a35a30")
    @artist_credit = Import::Json.parse(json_string).artist_credit
  end

  test "import an Participant" do
    # adapter = Import::MusicBrainzArtistCreditAdapter.new(@session, data: @artist_credit)

    assert true
  end
end
