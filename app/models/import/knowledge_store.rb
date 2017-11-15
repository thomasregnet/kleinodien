module Import
  # Knowledge of import-data is stored here
  class KnowledgeStore
    attr_reader :raw, :transformed, :transformer

    def initialize(args)
      @raw         = args[:raw] || {}
      @transformed = {}
      @transformer = args[:transformer]
    end

    def fetch(reference)
      ref_key = reference.to_key

      response = transformed[ref_key]
      return response if response

      transform(ref_key)
    end

    private

    def transform(ref_key)
      basic_material = raw[ref_key]
      return unless basic_material
      response = transformer.call(basic_material)
      transformed[ref_key] = response
      response
    end
  end
end
