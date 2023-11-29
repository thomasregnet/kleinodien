require "test_helper"
require "minitest/mock"

class Import::MusicbrainzFactoryTest < ActiveSupport::TestCase
  setup do
    @factory = Import::MusicbrainzFactory.new(:fake_import_order)
  end

  test "#attempt returns an Import::FaradayAttempt" do
    assert_kind_of Import::FaradayAttempt, @factory.attempt
  end

  test "#build_fetcher returns an Import::Fetcher" do
    assert_kind_of Import::Fetcher, @factory.build_fetcher("https://example.com")
  end

  test "#build_uri_string builds the expected uri_string" do
    assert_equal @factory.build_uri_string(:artist, "66c662b6-6e2f-4930-8610-912e24c63ed1"), "https://musicbrainz.org/ws/2/artist/66c662b6-6e2f-4930-8610-912e24c63ed1?fmt=json"
  end

  test "#connection returns a Faraday::Connection" do
    assert_kind_of Faraday::Connection, @factory.connection
  end

  test "#buffer returns an Import::Buffer" do
    assert_kind_of Import::Buffer, @factory.buffer
  end

  test "#interrupter returns an Import::MusicbrainzInterrupter" do
    assert_kind_of Import::MusicbrainzInterrupter, @factory.interrupter
  end

  test "#purify returns ruby-data" do
    response = Minitest::Mock.new
    response.expect :body, '{"name": "Suffocation"}'

    assert_equal @factory.purify(response)["name"], "Suffocation"
  end
end