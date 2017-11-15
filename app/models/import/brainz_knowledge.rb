module Import
  # Covers the field of knowledge MusicBrainz
  class BrainzKnowledge < KnowledgeField
    def initialize(args = {})
      super(
        KnowledgeStore.new(
          raw:         args[:known],
          transformer: proc { |xml_string| MashedBrainz.from_xml(xml_string) }
        )
      )
    end
  end
end
