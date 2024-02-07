require "test_helper"
require "minitest/mock"

class Import::MusicbrainzParticipantAdapterTest < ActiveSupport::TestCase
  setup do
    @musicbrainz_code = "66c662b6-6e2f-4930-8610-912e24c63ed1" # AC/DC
    @discogs_code = 84752

    @ancillary = Minitest::Mock.new
    @session = Minitest::Mock.new
  end

  def acdc
    json_string = File.read("test/webmock/musicbrainz.org/ws/2/artist/66c662b6-6e2f-4930-8610-912e24c63ed1_inc_url-rels.json")
    Import::Json.parse(json_string)
  end

  test "#prepare with code when no record can be found" do
    adapter = Import::MusicbrainzParticipantAdapter.new(@session, code: @musicbrainz_code)
    @session.expect :musicbrainz, @ancillary
    @ancillary.expect :get, acdc, [:artist, @musicbrainz_code]

    adapter.prepare

    @ancillary.verify
    @session.verify
  end

  test "#prepare with code when the record already exists" do
    participants(:one).update!(musicbrainz_code: @musicbrainz_code)
    adapter = Import::MusicbrainzParticipantAdapter.new(@session, code: @musicbrainz_code)

    assert_equal adapter.prepare.musicbrainz_code, @musicbrainz_code
  end

  test "#prepare xxx" do
    # xxx = {discogs_code: 123, imdb_code: "nm123"}
    test_values = [
      ["discogs_code", "123", "discogs", "https://discogs.com/artist/123"]
      # The column "participants.imdb_code" expects an integer
      # but "nm333" is a string
      # ["imdb_code", "nm333", "IMDb", "https://imdb.com/name/nm333"]
    ]

    test_values.each do |test_data|
      code_column, code, type, url = test_data
      @session.expect :musicbrainz, @ancillary
      @ancillary.expect :get, acdc, [:artist, @musicbrainz_code]

      Participant.create!(:name => "AC/DC", :sort_name => "AC/DC", code_column => code)

      data = OpenStruct.new(
        relations: [
          OpenStruct.new(
            target_type: "url",
            type: type,
            url: OpenStruct.new(resource: url)
          )
        ]
      )
      adapter = Import::MusicbrainzParticipantAdapter.new(@session, data: data, code: @musicbrainz_code)

      assert_equal adapter.prepare.name, "AC/DC"
    end
  end

  test "#prepare with data when no record can be found" do
    adapter = Import::MusicbrainzParticipantAdapter.new(@session, data: acdc)
    assert_nil adapter.prepare
  end

  test "#prepare with data when the record already exists" do
    participants(:one).update!(discogs_code: @discogs_code)
    adapter = Import::MusicbrainzParticipantAdapter.new(@session, data: acdc)
    assert_equal adapter.prepare.discogs_code, @discogs_code
  end
end
