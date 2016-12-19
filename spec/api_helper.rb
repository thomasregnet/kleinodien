module ApiHelper
  def json
    JSON.parse(response.body)
  end

  def api_get(url)
    get url, headers: { 'Accept' => 'application/vnd.api+json' }
  end
end
