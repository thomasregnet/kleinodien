module Import
  class MusicbrainzAlbumArchetypeFacade
    include Concerns::Scrapeable

    def initialize(facade_layer, options)
      @facade_layer = facade_layer
      @options = options
      Rails.logger.info("#{self.class}#initialize options: #{@options}")
    end

    attr_reader :facade_layer, :options

    delegate_missing_to :facade_layer

    def data
      # @data ||= request_layer.get(:release_group, options[:id])
      @data ||= request_layer.get(:release_group, musicbrainz_code)
    end

    def scraper_builder
      @@scraper_builder ||= Import::ScraperArchitect.build do
        define :title
        define :artist_credit
        # define :artist_credit, callback: ->(facade) { facade.artist_credit }
        define :archetypeable_type, always: "AlbumArchetype"
        define :discogs_code, always: nil
        define :wikidata_code, always: nil
        define :musicbrainz_code, callback: ->(facade) { facade.options[:code] }
      end
    end

    def artist_credit
      # data[:artist_credit].merge(kleinodien: {artist_credit_of: :album})
      {
        artist_credit: data[:artist_credit],
        kleinodien: {artist_credit_of: :album_archetype}
      }
    end

    def all_codes = {}

    def cheap_codes = {}

    # def musicbrainz_code = options[:musicbrainz_code] || options[:id]
    def musicbrainz_code
      Rails.logger.info(inspect)
      Rails.logger.info("options: #{options}")
      options[:musicbrainz_code] || options[:id]
    end
  end
end
