module Import
  class BrainzArtist
    attr_reader :artist, :data

    WANTED_RELATION_TYPES = %w(discogs).freeze

    def self.perform(data)
      new(data).perform
    end

    def initialize(data)
      multi_xml = MultiXml.parse(data)['metadata']['artist']
      @data = MashedBrainz::Artist.new(multi_xml)
    end

    def perform
      @artist = Artist.brainz_create!(data)
      import_brainz_identifer
      import_non_brainz_identifiers
      artist
    end

    def import_brainz_identifer
      artist.identifiers.create!(
        source: Source::MusicBrainz,
        value: data.id
      )
    end

    def import_non_brainz_identifiers
      wanted_relations.each do |relation|
        artist.identifiers.create!(
          source: Source.find_by(name: relation.type),
          value:  extract_value_from_url(relation.target.__content__)
        )
      end
    end

    def extract_value_from_url(url)
      m = url.match(%r{discogs.+\/(\d+)$})
      return m[1] if m
    end

    private

    def wanted_relations
      data.relation_list.relation.select do |relation|
        WANTED_RELATION_TYPES.include? relation.type
      end
    end
  end
end
