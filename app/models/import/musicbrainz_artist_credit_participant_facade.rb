module Import
  class MusicbrainzArtistCreditParticipantFacade
    include Concerns::Scrapeable

    def initialize(facade_layer, options)
      @facade_layer = facade_layer
      @options = options

      # debugger
    end

    attr_reader :facade_layer, :options
    delegate_missing_to :facade_layer

    def scraper_builder
      @@scraper_builder ||= Import::ScraperArchitect.build do
        define :join_phrase, :joinphrase
        define :participant, callback: ->(facade) { {musicbrainz_code: facade.musicbrainz_code} }
        define :position, callback: ->(facade) { facade.position }
      end
    end

    def data
      options
    end

    def join_phrase
      options[:joinphrase]
    end

    def musicbrainz_code
      debugger unless options[:artist]
      debugger unless options[:artist][:id]

      options[:artist][:id]
    end

    def position
      options[:position]
    end
  end
end
