module Import
  # Base class for Import::Knowledge*
  class KnowledgeAbout
    attr_reader :known

    def initialize
      @known = {}
      # TODO: @required
    end

    def about(reference)
      known[reference.to_key]
    end

    def about!(reference)
      raise Import::KnowledgeMissing
    end
  end
end
