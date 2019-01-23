# frozen_string_literal: true

# Prepare a MusicBrainz release for import
class PrepareBrainzRelease
  def self.call(args)
    new(args).call
  end

  def initialize(args)
    @blueprint = args[:blueprint]
    @proxy     = args[:proxy]
  end

  attr_reader :blueprint, :proxy

  def call
    heap = find_already_existing
    return heap if heap

    prepare_artist_credit
    prepare_release_group

    nil
  end

  def prepare_artist_credit
    PrepareBrainzArtistCredit.call(
      blueprint: blueprint.artist_credit,
      proxy:     proxy
    )
  end

  def prepare_release_group
    PrepareBrainzReleaseGroup.call(
      import_request: release_group_import_request,
      proxy:          proxy
    )
  end

  def release_group_import_request
    BrainzReleaseGroupImportRequest.new(
      code: blueprint.release_group.brainz_code
    )
  end

  def find_already_existing
    FindByCodesService.call(
      model_class: Heap,
      codes_hash:  blueprint.codes_hash
    )
  end
end
