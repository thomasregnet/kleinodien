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

    return if blueprint_complete?

    find_already_existing(full_blueprint.codes_hash)
  end

  def blueprint_complete?
    return false unless blueprint
    return true if blueprint.type

    false
  end

  def find_already_existing(codes_hash = nil)
    codes_hash ||= blueprint.codes_hash
    FindByCodesService.call(model_class: Artist, attributes: codes_hash)
  end

  def full_blueprint
    proxy.get(request)
  end

  def request
    BrainzArtistImportRequest.new(code: blueprint.brainz_code)
  end
end
