# Cache requirements and responses of foreign services needed for imports
class ImportCache
  private

  attr_reader :known, :required

  public

  CACHED_SOURCE_NAMES = %w[brainz discogs tmdb].freeze
  CACHED_TYPE_NAMES = %w[artist compilation compilation_release].freeze

  CACHED_SOURCE_NAMES.each do |source_name|
    CACHED_TYPE_NAMES.each do |type_name|
      define_method("fetch_#{source_name}_#{type_name}") do |id|
        known[source_name][type_name][id]
      end
    end
  end

  CACHED_SOURCE_NAMES.each do |source_name|
    CACHED_TYPE_NAMES.each do |type_name|
      define_method("store_#{source_name}_#{type_name}") do |id, data|
        known[source_name][type_name][id] = data
      end
    end
  end

  CACHED_SOURCE_NAMES.each do |source_name|
    CACHED_TYPE_NAMES.each do |type_name|
      define_method("require_#{source_name}_#{type_name}") do |requirement|
        required[source_name][type_name] = requirement
      end
    end
  end

  def initialize
    @known = init_cache
    @required = init_cache
  end

  private

  def init_cache
    cache = {}
    CACHED_SOURCE_NAMES.each do |source_name|
      cache[source_name] = {}
      CACHED_TYPE_NAMES.each do |type_name|
        cache[source_name][type_name] = {}
      end
    end
    cache
  end
end
