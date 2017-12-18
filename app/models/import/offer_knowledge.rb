module Import
  # Create the data structure of :known for Import::Offer
  class OfferKnowledge
    # OPTIMIZE: Maybe make a deep copy of :collected an return this
    attr_reader :collected

    def initialize
      @collected = {}
    end

    def add_with_reference(reference, data)
      category_store_for(reference)[reference.to_key] = data
    end

    private

    def category_store_for(reference)
      category = reference.category
      collected[category] ||= {}
    end
  end
end
