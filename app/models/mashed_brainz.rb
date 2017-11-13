# Representation of MusicBrainz data
module MashedBrainz
  def self.from_xml(xml_string)
    intermediate = Base.new(MultiXml.parse(xml_string)).metadata
    key_name = intermediate.keys.first
    intermediate[key_name]
  end
end
