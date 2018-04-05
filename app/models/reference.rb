# Base class for references
class Reference
  URI_SCHEME = 'https'.freeze

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

  def scheme
    URI_SCHEME
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

  # The eql?, == and hash methods are required to use a reference
  # as a hash key. For more information see
  # https://ruby-doc.org/core-2.4.2/Hash.html#class-Hash-label-Hash+Keys

  def ==(other)
    return false unless self.class == other.class
    return false unless to_uri == other.to_uri
    true
  end

  def to_s
    to_uri
  end

  alias_method 'eql?', '=='

  def hash
    to_uri.hash
  end
end
