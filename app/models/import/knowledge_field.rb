module Import
  # Base class for Import::Knowledge*
  class KnowledgeField
    attr_reader :known, :required

    def initialize
      @known = {}
      @required = Set.new
    end

    def about(reference)
      ref_key = reference.to_key

      response = known[ref_key]
      return response if response

      required.add(ref_key)

      nil
    end

    def missing?
      !required.empty?
    end

    def about!(reference)
      response = known[reference.to_key]
      return response if response
      raise Import::KnowledgeMissing
    end
  end
end
