# frozen_string_literal: true

# Persist a CompilationHead using data from MusicBrainz
class PersistBrainzCompilationHead
  def self.call(args)
    new(args).call
  end

  def initialize(args)
    @import_request = args[:import_request]
    @proxy          = args[:proxy]
  end

  attr_reader :import_request, :proxy

  def call
    find_already_existing || persist
  end

  def blueprint
    @blueprint ||= proxy.get(import_request)
  end

  def find_already_existing
    FindByCodesService.call(
      codes_hash:  blueprint.codes_hash,
      model_class: CompilationHead
    )
  end

  def persist
    artist_credit = persist_artist_credit

    # TODO: chose a type from the blueprint
    CompilationHead.create!(
      artist_credit: artist_credit,
      title:         blueprint.title,
      type:          'AlbumHead'
    )
  end

  def persist_artist_credit
    PersistBrainzArtistCredit.call(
      blueprint: blueprint.artist_credit,
      proxy:     proxy
    )
  end
end
