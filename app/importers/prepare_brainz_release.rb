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

    compilation_release = find_already_existing(blueprint.codes_hash)
    return compilation_release if compilation_release

    nil
  end

  def find_already_existing(codes_hash = nil)
    codes_hash ||= import_request_codes_hash

    FindByCodesService.call(
      model_class: CompilationRelease,
      attributes: codes_hash
    )
  end

  def import_request_codes_hash
    { brainz_code: import_request.code }
  end

  def blueprint
    proxy.get(import_request)
  end
end
