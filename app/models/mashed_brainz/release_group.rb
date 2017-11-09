module MashedBrainz
  # MusicBrainz release-group
  class ReleaseGroup < Base
    def self.xml(xml_string)
      new(parse_xml(xml_string)['release_group'])
    end

    def reference
      BrainzReleaseGroupRef.new(code: id)
    end
  end
end
