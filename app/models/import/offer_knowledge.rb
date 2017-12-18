module Import
  class OfferKnowledge
    attr_reader :known

    def initialize
      @known = {}
    end

    def add_with_reference(reference, data)
      category = reference.category
      known[category] ||= {}
      known[category][reference.to_key] = data
    end

    def collect
      known
    end
  end
end
