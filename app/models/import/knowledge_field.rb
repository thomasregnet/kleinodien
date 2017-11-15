module Import
  # Base class for Import::Knowledge*
  class KnowledgeField
    protected

    attr_reader :store

    private

    attr_reader :required

    public

    def initialize(store)
      @store    = store
      @required = Set.new
    end

    def about(reference)
      ref_key = reference.to_key

      response = store.fetch(reference)
      return response if response

      required.add(ref_key)

      nil
    end

    def missing?
      !required.empty?
    end

    def about!(reference)
      response = store.fetch(reference)
      return response if response
      raise Import::KnowledgeMissing
    end
  end
end
