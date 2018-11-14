# frozen_string_literal: true

# Prepare a MusicBrainz release for import
class PrepareBrainzRelease
  def self.call(args)
    new(args).call
  end

  def initialize(args)
    @import_request = args[:import_request]
    @proxy          = args[:proxy]
  end

  attr_reader :import_request, :proxy

  def call
    prepare
    persist
  end

  def prepare
    PrepareBrainzArtistCredit.call(
      blueprint: blueprint,
      proxy:     proxy
    )
  end

  def persist
    # TODO: implement persist
  end

  def blueprint
    @blueprint ||= proxy.get(import_request)
  end
end
