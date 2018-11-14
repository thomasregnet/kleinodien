module Importer
  # Persist a MusicBrainz release
  class PersistBrainzCompilationRelease < PersistBase
    def self.perform(args)
      new(args).perform
    end

    def initialize(args)
      super(args)
    end

    def perform
      original = blueprint
      original ||= store.request!(reference)

      artist_credit = persist_brainz_artist_credit(
        blueprint: original.artist_credit
      )
      compilation_head = persist_brainz_compilation_head(
        reference: original.release_group.reference
      )

      compilation_head.releases.create!(
        artist_credit: artist_credit,
        data_import:   data_import,
        title:         original.title
      )
    end
  end
end
