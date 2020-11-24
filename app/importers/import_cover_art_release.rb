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

  private

  def fetch_image(uri)
    import_request = CoverArtImageImportRequest.create!(import_order: import_order, uri: uri)
    response = CoverArtFetcher.call(import_request: import_request)

    StringIO.new(response.body)
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
    image = Image.create!(coverartarchive_code: metadata[:id])
    release_image = release_image_for(image, metadata)

    io = fetch_image(metadata[:image])
    release_image.file.attach(io: io, filename: metadata[:id])
    release_image.save!
  end

  def manifest
    @manifest ||= fetch_manifest
  end

  def release
    @release ||= Release.find_by(brainz_code: import_order.code)
  end

  def release_image_for(image, metadata)
    release.images.create!(
      back_cover:   metadata[:back],
      front_cover:  metadata[:front],
      image:        image,
      import_order: import_order,
      note:         metadata[:comment]
    )
  end
end
