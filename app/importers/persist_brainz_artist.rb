# frozen_string_literal: true

# Persist a MusicBrainz Artist
class PersistBrainzArtist
  def self.call(args)
    new(args).call
  end

  def initialize(args)
    @import_request = args[:import_request]
    @proxy          = args[:proxy]
  end

  attr_reader :import_request, :proxy

  def call
    artist = find_already_existing
    return artist if artist

    persist
  end

  def persist
    args = {
      name:           blueprint.name,
      sort_name:      blueprint.sort_name,
      disambiguation: blueprint.disambiguation
    }

    args[:begin_date]
    args[:end_date]

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
    return unless blueprint.dig(:life_span, :begin)

    IncompleteDate.from_string(blueprint.life_span.begin)
  end

  def end_date
    return unless blueprint.dig(:life_span, :end)

    IncompleteDate.from_string(blueprint.life_span.end)
  end
end
