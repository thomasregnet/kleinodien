require "test_helper"
require "minitest/mock"
require "support/retrieve"
require "support/retrieve/musicbrainz"

class MusicbrainzFacade::ParticipantTest < ActiveSupport::TestCase
  setup do
    @order = Minitest::Mock.new
    @reflections_factory = IngestionReflections::Factory.new
    @factory = MusicbrainzFacade::Factory.new(@order, @reflections_factory)

    @musicbrainz_code = "2280ca0e-6968-4349-8c36-cb0cbd6ee95f"
    @options = {musicbrainz_code: @musicbrainz_code}

    @subject = @factory.create(:participant, @options)
  end

  test "#all_codes" do
    known_codes = IngestionReflections::Participant.new(@reflections_factory)
      .inherent_attribute_names
      .filter { |attr| attr.end_with? "_code" }

    expected_codes = {
      discogs_code: "37752",
      imdb_code: "nm0080470",
      musicbrainz_code: "2280ca0e-6968-4349-8c36-cb0cbd6ee95f",
      tmdb_code: nil,
      wikidata_code: "334288"
    }.with_indifferent_access

    @subject.instance_variable_set(:@data, data)
    assert_equal expected_codes, @subject.scrape_many(known_codes)

    @order.verify
  end

  test "#cheap_codes" do
    assert_equal @musicbrainz_code, @subject.cheap_codes[:musicbrainz_code]
  end

  def data
    Import::Json.parse(json_string)
  end

  def json_string
    @json_string ||= Retrieve::Musicbrainz.new.call(:artist, @musicbrainz_code, %w[artist-rels url-rels])
  end
end
