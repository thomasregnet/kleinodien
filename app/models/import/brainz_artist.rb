module Import
  class BrainzArtist
    attr_reader :data

    def self.perform(data)
      new(data).perform
    end

    def initialize(data)
      multi_xml = MultiXml.parse(data)['metadata']['artist']
      @data = MashedBrainz::Artist.new(multi_xml)
    end

    def perform
      # FIXME: return an existing Artist
      #Artist.new
      Artist.brainz_create!(data)
    end
  end
end
