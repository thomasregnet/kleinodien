module Import
  # Persist a MusicBrainz release-group
  class PersistBrainzCompilationHead < PersistBase
    def self.perform(args)
      new(args).perform
    end

    def initialize(args)
      super(args)
    end

    def perform
      original = store.request!(reference)
      artist_credit = persist_brainz_artist_credit(
        blueprint: original.artist_credit
      )

      artist_credit.compilations.create!(
        title:          original.title,
        disambiguation: original.disambiguation,
        type:           'AlbumHead',
        data_import:    data_import
      )
    end
  end
end
