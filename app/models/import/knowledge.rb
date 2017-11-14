module Import
  # Known and required data to import
  class Knowledge
    KNOWLEDGE_FIELDS = {
      brainz: Import::BrainzKnowledge
      # TODO: discogs
      # TODO: tmdb
    }.freeze

    attr_reader :fields

    KNOWLEDGE_FIELDS.each_key do |field|
      define_method field do
        fields[field]
      end
    end

    def initialize(args = {})
      @fields = {}
      KNOWLEDGE_FIELDS.each do |field, klass|
        fields[field] = klass.new(args[field.to_s] || {})
      end
    end

    def missing?
      fields.each_value do |intance|
        return true if intance.missing?
      end
      false
    end
  end
end
