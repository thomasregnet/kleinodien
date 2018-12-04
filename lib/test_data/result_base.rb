module TestData
  class ResultBase
    def initialize(raw)
      @raw = raw
    end

    attr_reader :raw

    def to_s
      raw
    end
  end
end
