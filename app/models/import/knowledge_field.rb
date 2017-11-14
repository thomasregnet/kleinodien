module Import
  # Base class for Import::Knowledge*
  class KnowledgeField
    protected

    attr_reader :known

    private

    attr_reader :required

    public

    def initialize(known = {})
      @known    = known
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
