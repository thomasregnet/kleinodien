# frozen_string_literal: true

require 'test_data/base'
require 'test_data/brainz_result'

module TestData
  # Get MusicBrainz test-data
  class BrainzService < TestData::Base
    INC_FOR = {
      artist:  'artist-rels+url-rels',
      release: 'artists+labels+recordings+release-groups'
    }.freeze

    def self.blueprint(kind, code)
      path = "musicbrainz.org/#{kind}/#{code}?inc=#{INC_FOR[kind]}"
      new(path: path).blueprint
    end

    def self.call(args)
      path = "musicbrainz.org/#{args[:kind]}/#{args[:code]}" \
        "?inc=#{INC_FOR[args[:kind]]}"
      new(path: path).call
    end

    def blueprint
      xml_string = raw
      blueprint = BrainzBlueprint.from_xml(xml_string)
      blueprint[:raw_data] = xml_string
      blueprint
    end

    def call
      TestData::BrainzResult.new(raw)
    end
  end
end
