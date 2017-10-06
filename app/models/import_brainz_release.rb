# Post MusicBrainz params to kleinodien
class ImportBrainzRelease
  URL_PREFIX = 'https://musicbrainz.org/ws/2/release/'.freeze
  # TODO: add '+url-rels+recording-level-rels' to QUERY_STRING?
  QUERY_STRING = '?inc=artists+labels+recordings+release-groups'.freeze
  attr_reader :params, :cache

  def self.perform(params)
    new(params).perform
  end

  def initialize(params)
    @params = params
    @cache  = ImportCache.new
  end

  def perform
    prepare
    body
  end

  def body
    brainz_id = params[:data][:attributes][:wanted]
    cache.require_brainz(brainz_release_url_for(brainz_id))
    {
      data:
        {
          attributes: body_attributes
        }
    }
  end

  def body_attributes
    attributes = {}
    attributes[:http_status_code] = 202
    attributes[:required] = cache.required if cache.any_required?
    attributes
  end

  def prepare
    cache.rebuild_from_params(params)
    # TODO: check if the brainz release already exists in the database
    brainz_release_xml = get_cached_or_require
    if brainz_release_xml
      # TODO: Use MaschedBrainz if they are available
      ruby_data = MultiXml.parse(brainz_release_xml)
      #mashed_brain = MashedBrainz.new(ruby_data)
      brainz_release = MashedBrainz::Release.xml(brainz_release_xml)
    end
    # TODO: call `prepare` on related classes
  end

  def get_cached_or_require
    release_url = brainz_release_url
    brainz_release = cache.fetch_brainz(release_url)
    return brainz_release if brainz_release
    cache.require_brainz(release_url)
    false
  end

  def brainz_release_url
    brainz_release_url_for(params[:data][:attributes][:wanted])
  end

  def brainz_release_url_for(brainz_id)
    URL_PREFIX + brainz_id + QUERY_STRING
  end
end
