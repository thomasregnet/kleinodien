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
    return if find_already_existing

    proxy.get(request)
  end

  def find_already_existing
    # TODO: implement find_already_existing
  end

  def request
    # TODO: implement request
  end
end
