# frozen_string_literal: true

# Import cover art from coverartarchive.org
class ImportCoverArtRelease < ImportCoverArtBase
  def call
    manifest[:images].each do |img_data|
      response = fetch_image(img_data[:image])

      release_image = release.images.create!(
        back:             img_data[:back],
        front:            img_data[:front],
        # archive_org_code: img_data[:id],
        note:             img_data[:comment]
      )

      io = StringIO.new(response.body)
      release_image.file.attach(io: io, filename: img_data[:id])
      release_image.save!
    end
  end

  private

  def fetch_image(uri)
    import_request = CoverArtImageImportRequest.create!(import_order: import_order, uri: uri)
    CoverArtFetcher.call(import_request: import_request)
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
end
