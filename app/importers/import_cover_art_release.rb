# frozen_string_literal: true

# Import cover art from coverartarchive.org
class ImportCoverArtRelease < ImportCoverArtBase
  def call
    import_order.prepare!
    import_order.persist!

    if manifest
      manifest[:images].each { |metadata| import_image(metadata) }
    else
      Rails.logger.info("no images for #{import_order.code}")
    end

    import_order.done!
  end

  # Find at least one front_cover image of the release that was imported
  # form coverartarchive.org
  def find_existing
    ReleaseImage.joins(:image, :release)
                .where(releases: { brainz_code: brainz_code })
                .where(release_images: { front_cover: [true] })
                .where.not(images: { coverartarchive_code: [nil] })
                .any?
  end

  def prepare

  end

  private

  def brainz_code
    import_order.code
  end

  def fetch_manifest
    import_request = CoverArtReleaseManifestImportRequest.create!(
      code:         import_order.code,
      import_order: import_order
    )

    response = CoverArtFetcher.call(import_request: import_request)
    return unless response

    import_request.create_body!(content: response.body)
    JSON.parse(response.body, symbolize_names: true)
  end

  def import_image(metadata)
    release_image = release.images.build
    ImportCoverArtImage.call(import_order: import_order, metadata: metadata, target_object: release_image)
  end

  def manifest
    @manifest ||= fetch_manifest
  end

  def release
    @release ||= Release.find_by(brainz_code: import_order.code)
  end
end
