# frozen_string_literal: true

# Persist a MusicBrainz Artist
class PersistBrainzArtist
  def self.call(args)
    new(args).call
  end

  def initialize(args)
    @blueprint = args[:blueprint]
    @proxy     = args[:proxy]
  end

  attr_reader :blueprint, :proxy

  def call
    args = {
      name:           blueprint.name,
      sort_name:      blueprint.sort_name,
      disambiguation: blueprint.disambiguation
    }

    args[:begin_date] = begin_date if begin_date?
    args[:end_date] = begin_date if end_date?

    Artist.create!(args)
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
