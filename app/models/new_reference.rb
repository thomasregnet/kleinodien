# Base class for references
class NewReference
  attr_reader :code, :key, :uri

  def self.from_code(code)
    new(code: code)
  end

  def self.from_key(key)
    new(key: key)
  end

  def self.from_uri(uri)
    new(uri: uri)
  end

  private

  def initialize(args)
    @code = args[:code]
    @key  = args[:key]
    @uri  = args[:uri]
  end

  public

  def to_code
    return code if code
    source = key || uri
    match = %r{/([^?/]+)(\?.+)?$}.match(source)
    match[1]
  end
end
