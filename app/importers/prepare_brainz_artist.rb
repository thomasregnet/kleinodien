# frozen_string_literal: true

# Prepare a MusicBrainz artist for import
class PrepareBrainzArtist < PrepareBrainzBase
  def initialize(import_request:, **args)
    super(args)
    @import_request = import_request
  end

  attr_reader :import_request

  private

  def prepare
    find_already_existing || true
  end

  public

  def blueprint
    proxy.get(import_request)
  end

  def find_already_existing
    codes_hash = blueprint.codes_hash
    FindByCodesService.call(model_class: Artist, codes_hash: codes_hash)
  rescue StandardError => e
    raise e
  end
end
