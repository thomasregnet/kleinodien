# frozen_string_literal: true

# Prepare a MusicBrainz artist for import
class PrepareBrainzArtist < PrepareBrainzBase
  def initialize(args)
    super(args)
    @import_request = args[:import_request]
  end

  attr_reader :import_request

  def call
    artist = find_already_existing
    return artist if artist

    proxy.get(import_request)

    nil
  end

  def blueprint
    proxy.get(import_request)
  end

  def find_already_existing
    codes_hash = blueprint.codes_hash
    FindByCodesService.call(model_class: Artist, codes_hash: codes_hash)
  end
end
