module Import
  # Base class for Import::Knowledge*
  class KnowledgeField
    attr_reader :known

    def initialize
      @known = {}
      # TODO: @required
    end

    def about(reference)
      known[reference.to_key]
    end

    def about!(reference)
      response = known[reference.to_key]
      return response if response
      raise Import::KnowledgeMissing
    end
  end
end
