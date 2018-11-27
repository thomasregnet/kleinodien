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
    Artist.create!(
      name:           blueprint.name,
      sort_name:      blueprint.sort_name,
      disambiguation: blueprint.disambiguation
    )
  end
end
