module Import
  class From
    def initialize(fake_import_order)
      @fake_import_order = fake_import_order
    end

    def musicbrainz
      @musicbrainz ||= build_handler("Import::MusicbrainzFactory")
    end

    private

    attr_reader :import_order

    # def build_musicbrainz_handler
    #   factory = MusicbrainzFactory.new(import_order)
    #   FromHandler.new(factory)
    # end

    def build_handler(factory_name)
      factory = factory_name.constantize.new(import_order)
      FromHandler.new(factory)
    end
  end
end
