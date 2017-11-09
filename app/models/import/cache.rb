module Import
  # Cache requirements and responses of foreign services needed for imports
  class Cache
    attr_reader :known, :required

    CACHED_SOURCE_NAMES = %w[brainz discogs tmdb].freeze

    CACHED_SOURCE_NAMES.each do |source_name|
      define_method("fetch_#{source_name}") do |reference|
        known[source_name][reference.to_key]
      end

      define_method("fetch_#{source_name}!") do |reference|
        ref_key = reference.to_key
        entry = known[source_name][ref_key]
        raise Import::CacheMissingEntry, ref_key unless entry
        entry
      end

      define_method("store_#{source_name}") do |reference, data|
        known[source_name][reference.to_key] = data
      end

      define_method("require_#{source_name}") do |reference|
        return if required[source_name].include? reference.to_key
        required[source_name].push(reference.to_key)
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

    def rebuild_from_params(params)
      return unless params['data']
      return unless params['data']['attributes']
      to_know = params['data']['attributes']['known']
      return unless to_know
      CACHED_SOURCE_NAMES.each do |source_name|
        next unless to_know[source_name]
        to_know[source_name].each do |key, value|
          known[source_name][key] = value
        end
      end
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
end
