# frozen_string_literal: true

class ImportCoverArtRelease < ImportCoverArtBase
  def call
    front_params = manifest[:images].select { |img| img[:types].include? 'Front' }.first
    img = fetch_image(front_params[:image])

    io = StringIO.new(img)

    release.front_cover.attach(io: io, filename: 'foobar')
    release.save!
  end

  private

  def release
    @release ||= Release.find_by(brainz_code: import_order.code)
  end

  def manifest
    @manifest ||= fetch_manifest
  end

  def manifest_import_request
    @manifest_import_request ||= CoverArtReleaseManifestImportRequest.create(code: import_order.code)
  end

  def fetch_manifest
    import_request = CoverArtReleaseManifestImportRequest.create!(
      code:         import_order.code,
      import_order: import_order
    )

    body = fetch(import_request)
    return unless body

    JSON.parse(body, symbolize_names: true)
  end

  def fetch_image(uri)
    import_request = CoverArtImageImportRequest.create!(import_order: import_order, uri: uri)

    fetch(import_request)
  end

  def fetch(import_request)
    max_fetch_tries.times do
      take_a_nap
      response = Faraday.get(import_request.uri)
      attemp(import_request, response)
      if response.success?
        import_request.run!
        import_request.done!
        return response.body
      end

      import_request.failure!
      nil
    end
  end

  def attemp(import_requeet, response)
    import_request.attempts.create!(
      message:     response.reason_phrase,
      status_code: response.status
    )
  end

  def max_fetch_tries
    5
  end

  def take_a_nap
    sleep 0
  end
end
