module Import
  class PrepareRawData
    attr_reader :data, :reference

    def self.perform(reference, data)
      new(reference, data).perform
    end

    def initialize(reference, data)
      @reference = reference
      @data      = data
    end

    def perform
      #byebug
      case reference.category
      when :brainz
        MashedBrainz.from_xml(data)
      end
    end
  end
end
