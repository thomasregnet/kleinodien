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
      references[reference.to_key] = reference
      reference
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
