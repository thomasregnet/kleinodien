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
  end
end
