# frozen_string_literal: true

# Persist a CompilationHead using data from MusicBrainz
class PersistBrainzHeapHead < PersistBrainzBase
  def initialize(args)
    super(args)
    @import_request = args[:import_request]
  end

  attr_reader :import_request

  def call
    find_already_existing || persist
  end

  def blueprint
    @blueprint ||= proxy.get(import_request)
  end

  def find_already_existing
    FindByCodesService.call(
      codes_hash:  blueprint.codes_hash,
      model_class: HeapHead
    )
  end

  def persist
    artist_credit = persist_artist_credit

    # TODO: chose a type from the blueprint
    HeapHead.create!(
      artist_credit: artist_credit,
      title:         blueprint.title,
      type:          type
    )
  end

  def persist_artist_credit
    PersistBrainzArtistCredit.call(
      blueprint: blueprint.artist_credit,
      proxy:     proxy
    )
  end

  def type
    ChooseBrainzHeapHeadClassService.call(type: blueprint.type)
  end
end
