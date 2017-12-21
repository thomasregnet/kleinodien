module Import
  class Offer
    attr_reader :known, :offered, :type

    def initialize(args)
      @known   = args[:knowledge] || OfferKnowledge.new
      @offered = args[:offered]
      @type    = args[:type]
    end

    def to_hash
      {
        data:
          {
            attributes: {
              known: known.collected,
              offered: offered
            }
          }
      }
    end

    def teach
      yield known
    end
  end
end
