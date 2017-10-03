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
      define_method("require_#{source_name}_#{type_name}") do |path, id = nil|
        required[source_name][type_name][path] = id
      end
    end
  end

  def initialize
    @known = init_cache
    @required = init_cache
  end

  def render
    realy_required = {}

    required.each do |source_name, types|
      required_types = required_types_of(source_name)
      next if required_types.length.zero?
      realy_required[source_name] = {} unless realy_required[source_name]
      realy_required[source_name] = required_types
    end

    #realy_required
    {
      data: {
        attributes: {
          required: realy_required
        }
      }
    }
  end

  def required_types_of(source_name)
    required_types = {}

    types = required[source_name]
    types.each do |type_name, requirements|
      next if types[type_name].length.zero?
      required_types[type_name] = requirements
    end

    required_types
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
