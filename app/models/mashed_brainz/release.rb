module MashedBrainz
  class Release < Base
    def self.xml(xml_string)
      new(parse_xml(xml_string)['release'])
    end
    
    def brainz_id
      BrainzReleaseId.new(id)
    end

    def source_id
      brainz_id.source_id
    end
  end
end
