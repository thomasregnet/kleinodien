# frozen_string_literal: true

# Import cover art from coverartarchive.org
class ImportCoverArtRelease < ImportCoverArtBase
  def call
    import_order.prepare!
    import_order.persist!

    manifest[:images].each do |img_metadata|
      release_image = release_image_for(img_metadata)

      io = fetch_image(img_metadata[:image])
      release_image.file.attach(io: io, filename: img_metadata[:id])
      release_image.save!
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

  def manifest
    @manifest ||= fetch_manifest
  end

  def release
    @release ||= Release.find_by(brainz_code: import_order.code)
  end

  def release_image_for(img_metadata)
    release.images.create!(
      archive_org_code: img_metadata[:id],
      back:             img_metadata[:back],
      front:            img_metadata[:front],
      import_order:     import_order,
      note:             img_metadata[:comment]
    )
  end
end
