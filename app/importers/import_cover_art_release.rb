# frozen_string_literal: true

# Import cover art from coverartarchive.org
class ImportCoverArtRelease < ImportCoverArtBase
  def call
    front_params = manifest[:images].select { |img| img[:types].include? 'Front' }.first
    response = fetch_image(front_params[:image])

    io = StringIO.new(response.body)

    release.front_cover.attach(io: io, filename: 'foobar')
    release.save!
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
