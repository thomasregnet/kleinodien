module Import
  class Offer
    attr_reader :knowledge, :offered, :type

    def initialize(args)
      @knowledge   = args[:knowledge] || {}
      @offered = args[:offered]
      @type    = args[:type]
    end

    def to_hash
      {
        data:
          {
            attributes: {
              #known: knowledge,
              knowledge: knowledge,
              offered: offered
            }
          }
      }
    end

    def teach(reference, data)
      knowledge[reference.to_uri] = data
    end
  end
end
