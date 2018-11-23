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
    artist = find_already_existing
    return artist if artist

    proxy.get(import_request)
    nil
  end

  def find_already_existing
    codes_hash = blueprint.codes_hash
    FindByCodesService.call(model_class: Artist, codes_hash: codes_hash)
  end

  def import_request
    BrainzArtistImportRequest.new(code: blueprint.brainz_code)
  end
end
