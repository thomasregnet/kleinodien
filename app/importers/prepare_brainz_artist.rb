# frozen_string_literal: true

# Prepare a MusicBrainz artist for import
class PrepareBrainzArtist
  def self.call(args)
    new(args).call
  end

  def initialize(args)
    @blueprint = args[:blueprint]
    @proxy     = args[:proxy]
  end

  attr_reader :blueprint, :proxy

  def call
    return if already_have

    proxy.get(request)
  end

  def already_have
    # TODO: implement already_have
  end

  def request
    # TODO: implement request
  end
end
