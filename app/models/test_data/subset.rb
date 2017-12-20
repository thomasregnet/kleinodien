module TestData
  # Subset of TestData
  class Subset
    private

    attr_reader :data_for

    public

    def initialize
      @data_for = {}
    end

    def add(kind, code)
      require_kind(kind)
      ref_class = ref_to_require(kind).camelize.constantize
      reference = ref_class.from_code(code)
      data_for[reference] = nil
      reference
    end

    def add_reference(reference)
      @data_for[reference] = nil
    end

    def add_references(new_references)
      new_references.each do |reference|
        add_reference(reference)
      end
    end

    def fetch(reference)
      response = data_for[reference]
      return response if response
      # TODO: raise when reference is not part of data_for
      # make shure that the required data belongs to this subset
      return unless data_for.key? reference
      data_for[reference] = Fetch.perform(reference)
    end

    def to_hash
      response = {}
      references.each do |reference|
        category_hash = response[reference.category] ||= {}
        category_hash[reference.to_key] = fetch(reference)
      end

      response
    end

    def references
      data_for.keys
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
