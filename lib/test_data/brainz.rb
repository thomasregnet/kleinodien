# frozen_string_literal: true

require 'test_data/base'

module TestData
  # Get MusicBrainz test-data
  class Brainz < TestData::Base
    INC_FOR = {
      artist: 'artist-rels+url-rels'
    }.freeze

    def self.blueprint(kind, code)
      path = "musicbrainz.org/#{kind}/#{code}?inc=#{INC_FOR[kind]}"
      new(path).blueprint
    end

    def blueprint
      xml_string = raw
      blueprint = BrainzBlueprint.from_xml(xml_string)
      blueprint[:raw_data] = xml_string
      blueprint
    end
  end
end
