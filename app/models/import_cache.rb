# Cache requirements and responses of foreign services needed for imports
class ImportCache
  attr_reader :known, :required

  CACHED_SOURCE_NAMES = %w[brainz discogs tmdb].freeze

  CACHED_SOURCE_NAMES.each do |source_name|
    define_method("fetch_#{source_name}") do |uri|
      known[source_name][uri]
    end

    define_method("store_#{source_name}") do |uri, data|
      known[source_name][uri] = data
    end

    define_method("require_#{source_name}") do |uri|
      return if required[source_name].include? uri
      required[source_name].push(uri)
    end
  end

  def initialize
    @known    = init_cache(Hash)
    @required = init_cache(Array)
  end

  def any_required?
    CACHED_SOURCE_NAMES.each do |source_name| 
      return true unless required[source_name].empty?
    end

    false
  end
  private

  def init_cache(klass)
    cache = {}

    CACHED_SOURCE_NAMES.each do |source_name|
      cache[source_name] = klass.new
    end

    cache
  end
end
