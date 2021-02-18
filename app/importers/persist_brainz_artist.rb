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
    args = {
      name:           blueprint.name,
      sort_name:      blueprint.sort_name,
      disambiguation: blueprint.disambiguation,
      import_order:   import_order
    }

    args[:begin_date] = begin_date if begin_date
    args[:end_date]   = end_date if end_date

    Artist.create!(args)
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

  def begin_date
    blueprint.incomplete_begin_date
  end

  def end_date
    blueprint.incomplete_end_date
  end
end
