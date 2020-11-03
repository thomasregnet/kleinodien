# frozen_string_literal: true

# Persist a CompilationHead using data from MusicBrainz
class PersistBrainzReleaseHead < PersistBrainzBase
  def initialize(code:, **args)
    super(args)
    @code = code
  end

  attr_reader :code

  def call
    find_already_existing || persist
  end

  def blueprint
    @blueprint ||= proxy.get(:release_group, code)
  end

  def find_already_existing
    by_code = FindByCodesService.call(codes_hash: { brainz_code: code }, model_class: ReleaseHead)
    return by_code if by_code

    FindByCodesService.call(codes_hash: blueprint.codes_hash, model_class: ReleaseHead)
  end

  # rubocop:disable Metrics/MethodLength
  def persist
    arguments = {
      artist_credit: artist_credit,
      import_order:  import_order,
      title:         blueprint.title,
      type:          type
    }

    ReleaseHead.create!(
      CodesForModelService.call(
        codes_hash:  blueprint.codes_hash,
        given:       arguments,
        model_class: ReleaseHead
      )
    )
  end
  # rubocop:enable Metrics/MethodLength

  def artist_credit
    persist_artist_credit(blueprint: blueprint.artist_credit)
  end

  def type
    ChooseBrainzReleaseHeadTypeService.call(brainz_type: blueprint.type)
  end
end
