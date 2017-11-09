module MashedBrainz
  class Release < Base
    def self.xml(xml_string)
      new(parse_xml(xml_string)['release'])
    end
  end
end
