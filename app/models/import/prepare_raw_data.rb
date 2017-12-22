module Import
  # Prepare raw data depending on the category of it's reference
  class PrepareRawData
    attr_reader :data, :reference

    def self.perform(reference, data)
      new(reference, data).perform
    end

    def initialize(reference, data)
      @reference = reference
      @data      = data
    end

    # TODO: prepare Discogs data
    # TODO: prepare Tmdb data
    def perform
      category = reference.category
      case category
      when :brainz
        MashedBrainz.from_xml(data)
      else
        raise "can't prepare data for #{category}"
      end
    end
  end
end
