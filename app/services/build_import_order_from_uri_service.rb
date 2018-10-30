# frozen_string_literal: true

# Takes an uri as parameter and returns an initialized ImportOrder object
class BuildImportOrderFromUriService
  CLASS_NAME_FOR = {
    'discogs'     => 'DiscogsImportOrder',
    'musicbrainz' => 'BrainzImportOrder'
  }.freeze

  PARAMS_CLASS_FOR = {
    'musicbrainz' => 'BrainzImportOrderParamsFromUriService'
  }.freeze

  attr_reader :uri_string

  def self.call(uri_string)
    new(uri_string).call
  end

  def initialize(uri_string)
    @uri_string = uri_string
  end

  def call
    return unless class_name

    class_name.constantize.new(params)
  end

  private

  def class_name
    CLASS_NAME_FOR[host_key]
  end

  def host_key
    return unless uri

    uri.host.split('.')[-2]
  end

  def params
    return unless host_key

    PARAMS_CLASS_FOR[host_key].constantize.call(uri)
  end

  def parse_uri
    URI.parse(uri_string)
  rescue URI::BadURIError
    nil
  rescue URI::InvalidURIError
    nil
  end

  def uri
    @uri ||= parse_uri
  end
end
