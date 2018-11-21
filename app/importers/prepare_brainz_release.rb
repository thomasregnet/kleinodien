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
    compilation_release = find_already_existing
    return compilation_release if compilation_release

    prepare_artist_credit
    prepare_release_group
    nil
  end

  def prepare_artist_credit
  end

  def prepare_release_group
  end

  def find_already_existing
    compilation_release = CompilationRelease.find_by(
      brainz_code: import_request.code
    )
    return compilation_release if compilation_release

    FindByCodesService.call(
      model_class: CompilationRelease,
      attributes:  blueprint.codes_hash
    )
  end

  def import_request_codes_hash
    { brainz_code: import_request.code }
  end

  def blueprint
    proxy.get(import_request)
  end
end
