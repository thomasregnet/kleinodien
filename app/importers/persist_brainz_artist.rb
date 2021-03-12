# frozen_string_literal: true

# Persist a MusicBrainz Artist
class PersistBrainzArtist < PersistBrainzBase
  def initialize(code:, **args)
    super(**args)
    @code = code
  end

  attr_reader :code

  def call
    artist = find_already_existing
    return artist if artist

    persist
  end

  def persist
    Artist.create(
      name:           blueprint.name,
      sort_name:      blueprint.sort_name,
      disambiguation: blueprint.disambiguation,
      import_order:   import_order,
      begin_date:     blueprint.begin_date,
      end_date:       blueprint.end_date
    )
  end

  private

  def blueprint
    proxy.get(:artist, code)
  end

  def find_already_existing
    FindByCodesService.call(
      model_class: Artist,
      codes_hash:  blueprint.codes_hash
    )
  end
end
