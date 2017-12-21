module Import
  class Offer
    attr_reader :knowledge, :offered, :type

    def initialize(args)
      @knowledge   = args[:knowledge] || OfferKnowledge.new
      @offered = args[:offered]
      @type    = args[:type]
    end

    def to_hash
      {
        data:
          {
            attributes: {
              known: knowledge.collected,
              offered: offered
            }
          }
      }
    end

    def teach
      yield knowledge
    end
  end
end
