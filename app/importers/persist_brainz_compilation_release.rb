# frozen_string_literal: true

# Persist a CompilationRelease using data retrieved from MusicBrainz
class PersistBrainzCompilationRelease
  def self.call(args)
    new(args).call
  end

  def initialize(args)
    # @import_request = args[:import_request]
    @blueprint = args[:blueprint]
    @proxy     = args[:proxy]
  end

  attr_reader :blueprint, :proxy

  def call
    find_already_existing || persist
  end

  def find_already_existing
    FindByCodesService.call(
      codes_hash:  blueprint.codes_hash,
      model_class: CompilationRelease
    )
  end

  def persist
  end

  def persist_artist_credit
  end

  def persist_compilation_head
  end
end
