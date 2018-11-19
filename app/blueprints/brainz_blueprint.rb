# frozen_string_literal: true

# Blueprint for MusicBrainz-imports
class BrainzBlueprint < Hashie::Mash
  disable_warnings

  def self.from_xml(xml_string)
    intermidiate = new(MultiXml.parse(xml_string)).metadata
    intermidiate[intermidiate.keys.first]
  end
end
