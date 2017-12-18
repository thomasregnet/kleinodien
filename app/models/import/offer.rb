module Import
  class Offer
    attr_reader :known, :offered, :type

    def initialize(args)
      @known   = args[:known] || {}
      @offered = args[:offered]
      @type    = args[:type]
    end
  end
end
