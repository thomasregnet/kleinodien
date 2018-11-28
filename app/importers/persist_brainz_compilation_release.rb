# frozen_string_literal: true

# Persist a CompilationRelease using data retrieved from MusicBrainz
class PersistBrainzCompilationRelease
  def self.call(args)
    new(args).call
  end

  def initialize(args)
    @blueprint = args[:blueprint]
    @proxy     = args[:proxy]
  end

  attr_reader :blueprint, :proxy

  def call
    find_already_existing || persist
  end

  def find_already_existing
    FindByCodesService.call(
      codes_hash:  blueprint.codes_hash,
      model_class: CompilationRelease
    )
  end

  def persist
    artist_credit = persist_artist_credit
    compilation_head = persist_compilation_head
    # TODO: Persist the right type, not always 'album'
    CompilationRelease.create!(
      artist_credit: artist_credit,
      head:          compilation_head,
      title:         blueprint.title,
      type:          AlbumRelease
    )
  end

  def persist_artist_credit
    artist_credit = find_already_existing_artist_credit
    return artist_credit if artist_credit

    PersistBrainzArtistCredit.call(
      blueprint: blueprint.artist_credit,
      proxy:     proxy
    )
  end

  def find_already_existing_artist_credit
    ArtistCredit.find_by(name: blueprint.artist_credit.join_name)
  end

  def persist_compilation_head
    compilation_head = find_already_existing_compilation_head
    return compilation_head if compilation_head

    import_request = BrainzReleaseGroupImportRequest.new(
      code: blueprint.release_group.brainz_code
    )

    PersistBrainzCompilationHead.call(
      blueprint: proxy.get(import_request),
      proxy:     proxy
    )
  end

  def find_already_existing_compilation_head
    CompilationHead.find_by(brainz_code: blueprint.brainz_code)
  end
end
