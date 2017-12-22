module Import
  class PrepareRawData
    def self.perform(reference, data)
      new(reference, data).perform
    end

    def initialize(reference, data)
      @reference = reference
      @data      = data
    end

    def perform
      Hashie::Mash.new
    end
  end
end
