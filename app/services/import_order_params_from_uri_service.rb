# frozen_string_literal: true

# Base for *ImportOrderParamsFromUriService classes
class ImportOrderParamsFromUriService
  DEFAULT_OFFSET = 0

  def self.call(uri)
    new(uri).call
  end

  attr_reader :uri

  def initialize(uri)
    @uri = uri
  end

  def call
    return unless path_items

    {
      code: path_items[offset + 1],
      kind: path_items[offset]
    }
  end

  private

  def offset
    DEFAULT_OFFSET
  end

  def path_items
    return unless path_string

    items = path_string.split('/')
    return unless items.length >= 2

    items
  end

  def path_string
    # an path returned from the uri-object will look like
    # '/foo/bar'. The leading slash ('/') distrubs so remove it
    with_leading_slash = uri.path
    return unless with_leading_slash

    with_leading_slash.sub(%r{^/}, '')
  end
end
