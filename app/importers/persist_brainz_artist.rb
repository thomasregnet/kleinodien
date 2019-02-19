# frozen_string_literal: true

# Persist a MusicBrainz Artist
class PersistBrainzArtist < PersistBrainzBase
  def initialize(args)
    super(args)
    @import_request = args[:import_request]
  end

  attr_reader :import_request

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

    args[:begin_date] = begin_date if begin_date?
    args[:end_date]   = end_date   if end_date?

    Artist.create!(args)
  end

  def blueprint
    proxy.get(import_request)
  end

  def find_already_existing
    FindByCodesService.call(
      model_class: Artist,
      codes_hash:  blueprint.codes_hash
    )
  end

  def begin_date
    return unless begin_date?

    IncompleteDate.from_string(blueprint.life_span.begin)
  end

  def begin_date?
    return true if blueprint.dig(:life_span, :begin)

    false
  end

  def end_date
    return unless end_date?

    IncompleteDate.from_string(blueprint.life_span.end)
  end

  def end_date?
    return true if blueprint.dig(:life_span, :end)

    false
  end
end
