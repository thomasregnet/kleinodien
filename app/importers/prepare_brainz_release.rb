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
    compilation_release = find_already_existing
    return compilation_release if compilation_release

    prepare_artist_credit
    prepare_release_group

    nil
  end

  def prepare_artist_credit
    return if find_already_existing_artist_credit

    PrepareBrainzArtistCredit.call(
      blueprint: blueprint.artist_credit,
      proxy:     proxy
    )
  end

  def prepare_release_group
    PrepareBrainzReleaseGroup.call(
      blueprint: proxy.get(release_group_import_request),
      proxy:     proxy
    )
  end

  def release_group_import_request
    return if find_already_existing_release_group

    BrainzReleaseGroupImportRequest.new(
      code: blueprint.release_group.brainz_code
    )
  end

  def find_already_existing
    FindByCodesService.call(
      model_class: CompilationRelease,
      codes_hash:  blueprint.codes_hash
    )
  end

  def find_already_existing_artist_credit
    ArtistCredit.find_by(name: blueprint.artist_credit.join_name)
  end

  def find_already_existing_release_group
    CompilationHead.find_by(brainz_code: blueprint.code)
  end
end
