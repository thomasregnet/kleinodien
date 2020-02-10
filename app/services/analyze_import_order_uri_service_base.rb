# frozen_string_literal: true

# Base for *ImportOrderParamsFromUri_ObjService classes
class AnalyzeImportOrderUriServiceBase < ServiceBase
  DEFAULT_OFFSET = 0

  def initialize(uri_obj:)
    @uri_obj = uri_obj
    # @user = args[:user]
  end

  attr_reader :uri_obj # , :user

  def call
    return unless path_items

    {
      code: code,
      kind: kind,
      type: type
    }
  end

  protected

  def code
    path_items[offset + 1]
  end

  def kind
    @kind ||= path_items[offset]
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
    # an path returned from the uri_obj-object will look like
    # '/foo/bar'. The leading slash ('/') distrubs so remove it
    with_leading_slash = uri_obj.path
    return unless with_leading_slash

    with_leading_slash.sub(%r{^/}, '')
  end
end
