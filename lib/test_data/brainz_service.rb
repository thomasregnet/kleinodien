# frozen_string_literal: true

require 'test_data/brainz_result'
require 'test_data/path_service'

module TestData
  # Get MusicBrainz test-data
  class BrainzService
    INC_FOR = {
      artist:  'artist-rels+url-rels',
      release: 'artists+labels+recordings+release-groups'
    }.freeze

    def self.call(args)
      new(args).call
    end

    def initialize(args)
      @code = args[:code]
      @kind = args[:kind]
    end

    attr_reader :code, :kind

    def call
      path = "musicbrainz.org/#{kind}/#{code}?inc=#{INC_FOR[kind]}"
      raw = TestData::PathService.call(path)
      TestData::BrainzResult.new(raw)
    end
  end
end
