# Cache requirements and responses of foreign services needed for imports
class ImportFlatCache
  private

  attr_reader :known, :required

  public

  CACHED_SOURCE_NAMES = %w[brainz discogs tmdb].freeze
  CACHED_TYPE_NAMES = %w[artist compilation compilation_release].freeze

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

  private

  def init_cache(klass)
    cache = {}

    CACHED_SOURCE_NAMES.each do |source_name|
      cache[source_name] = klass.new
    end

    cache
  end
end
