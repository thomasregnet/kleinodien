# frozen_string_literal: true

# Persist an ArtistCredit from MusicBrainz
class PersistBrainzArtistCredit
  def self.call(args)
    new(args).call
  end

  def initialize(args)
    @blueprint = args[:blueprint]
    @proxy     = args[:proxy]
  end

  attr_reader :import_request, :proxy

  def call
  end
end
