module ApiHelper
  def json
    JSON.parse(response.body)
  end

  # see https://github.com/rspec/rspec-rails/issues/1655
  def set_request_content_type_to_vnd_api_json
    headers = { 'Content-Type' => 'application/vnd.api+json' }
    request.headers.merge! headers
  end
end
