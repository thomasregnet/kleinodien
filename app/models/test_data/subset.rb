module TestData
  # Subset of TestData
  class Subset
    private

    attr_reader :references

    public

    def initialize
      @references = {}
    end

    def add(kind, code)
      require_kind(kind)
      ref_class = ref_to_require(kind).camelize.constantize
      reference = ref_class.from_code(code)
      #references[reference.to_key] = reference
      references[reference] = nil
      reference
    end

    def add_reference(reference)
      @references[reference] = nil
    end

    def fetch(reference)
      response = references[reference]
      return response if response
      # TODO: raise when reference is not part of references
      return unless references.key? reference
      response = Fetch.perform(reference)
      #byebug
      response
    end

    private

    def require_kind(kind)
      require ref_to_require(kind)
    rescue LoadError
      raise ArgumentError, "invalid kind: #{kind}"
    end

    def ref_to_require(kind)
      "#{kind}_reference"
    end
  end
end
