module Import
  # Covers the field of knowledge MusicBrainz
  class BrainzKnowledge < KnowledgeField
    def initialize(args = {})
      super
      known_xml = args[:known] || return
      xml_to_template(known_xml)
    end

    private

    def xml_to_template(known_xml)
      known_xml.each do |ref_key, xml_string|
        known[ref_key] = MashedBrainz.from_xml(xml_string)
      end
    end
  end
end
