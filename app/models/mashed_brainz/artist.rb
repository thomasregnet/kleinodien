module MashedBrainz
  class Artist < Base
    def self.xml(xml_string)
      new(parse_xml(xml_string)['artist'])
    end

    def brainz_id
      BrainzArtistRef.new(code: id)
    end

    def source_id
      brainz_id.source_id
    end
  end
end
