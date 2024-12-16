module LayeredImport
  class MusicbrainzParticipantFacade
    def initialize(facade_layer, options)
      @facade_layer = facade_layer
      @options = options
    end

    attr_reader :facade_layer, :options

    delegate_missing_to :facade_layer

    def data
      @data ||= request_layer.get(:artist, options[:musicbrainz_code])
    end

    def name = data[:name]

    def sort_name = data[:sort_name]

    def disambiguation = data[:disambiguation]

    def begins_at
      # TODO: implement #begins_at
    end

    def ends_at
      # TODO: implement #ends_at
    end

    def discogs_code
      # TODO: implement #discogs_code
    end

    def imdb_code
      # TODO: implement #imdb_code
    end

    def musicbrainz_code
      # TODO: implement #musicbrainz_code
    end

    def tmdb_code
      # TODO: implement #tmdb_code
    end

    def wikidata_code
      # TODO: implement #wikidata_code
    end
  end
end
