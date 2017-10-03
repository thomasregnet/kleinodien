# Cache requirements and responses of foreign services needed for imports
class ImportFlatCache
  private

  attr_reader :known, :required

  public

  CACHED_SOURCE_NAMES = %w[brainz discogs tmdb].freeze
  CACHED_TYPE_NAMES = %w[artist compilation compilation_release].freeze

  CACHED_SOURCE_NAMES.each do |source_name|
    CACHED_TYPE_NAMES.each do |type_name|
      key_name = "#{source_name}_#{type_name}"

      define_method("fetch_#{source_name}_#{type_name}") do |id|
        known[key_name][id]
      end

      define_method("store_#{source_name}_#{type_name}") do |id, data|
        known[key_name][id] = data
      end

      define_method("require_#{source_name}_#{type_name}") do |uri|
        required[key_name][uri]
      end
    end
  end

  def initialize
    @known    = init_cache
    @required = init_cache
  end

  private

  def init_cache
    cache = {}
    CACHED_SOURCE_NAMES.each do |source_name|
      CACHED_TYPE_NAMES.each do |type_name|
        cache["#{source_name}_#{type_name}"] = {}
      end
    end

    cache
  end
end
