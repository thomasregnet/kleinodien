# frozen_string_literal: true

# Prepares a MusicBrainz Recording for import.
class PrepareBrainzRecording
  def self.call(args)
    new(args).call
  end

  def initialize(args)
    @import_request = args[:import_request]
    @proxy          = args[:proxy]
  end

  attr_reader :import_request, :proxy

  def call
    piece = find_already_existing
    return piece if piece

    blueprint

    nil
  end

  def blueprint
    proxy.get(import_request)
  end

  def find_already_existing
    codes_hash = blueprint.codes_hash
    FindByCodesService.call(model_class: Piece, codes_hash: codes_hash)
  end
end
