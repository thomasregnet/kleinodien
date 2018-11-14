# frozen_string_literal: true

# Prepare a MusicBrainz Artist for import
class PrepareBrainzArtistCredit
  def self.call(args)
    new(args).call
  end

  def initialize(args)
    @blueprint = args[:blueprint]
    @proxy     = args[:proxy]
  end

  attr_reader :blueprint, :proxy

  def call
    artists = proxy.get(:foo)
  end
end
