module Import
  # Known and required data to import
  class Knowledge
    attr_reader :having, :missing

    def initialize(args = {})
      @having  = args[:having] || {}
      @missing = Set.new
    end

    def about(reference)
      known = having[reference]
      missing.add(reference) unless known
      return unless known
      PrepareRawData.perform(reference, known)
    end

    def about!(reference)
      response = about(reference)
      raise KnowledgeMissing unless response
      response
    end

    def collect
      {
        required: collect_required
      }
    end

    def collect_required
      required = {}
      missing.each do |reference|
        category = reference.category
        list = required[category] ||= []
        list << reference.to_uri
      end
      required
    end

    def missing?
      !missing.empty?
    end
  end
end
# module Import
#   # Known and required data to import
#   class Knowledge
#     KNOWLEDGE_FIELDS = {
#       brainz: Import::BrainzKnowledge
#       # TODO: discogs
#       # TODO: tmdb
#     }.freeze

#     attr_reader :fields

#     KNOWLEDGE_FIELDS.each_key do |field|
#       define_method field do
#         fields[field]
#       end
#     end

#     def initialize(args = {})
#       args ||= {}
#       @fields = {}
#       known = args.fetch(:known, {})
#       KNOWLEDGE_FIELDS.each do |field, klass|
#         raw = known[field] || {}
#         fields[field] = klass.new(known: raw)
#       end
#     end

#     def collect
#       response = { known: {}, required: {} }
#       fields.each do |name, field|
#         collected = field.collect
#         response[:known][name] = collected[:known]
#         response[:required][name] = collected[:required]
#       end
#       response
#     end

#     def missing?
#       fields.each_value do |intance|
#         return true if intance.missing?
#       end
#       false
#     end
#   end
# end
