# frozen_string_literal: true

# Get the ImportOrder class name for a given uri
class GetImportOrderClassNameFromUriService
  CLASS_NAME_FOR = {
    'discogs'     => 'DiscogsImportOrder',
    'musicbrainz' => 'MusicBrainzImportOrder'
  }.freeze

  def self.call(uri_string)
    new(uri_string).call
  end

  attr_reader :uri_string

  def initialize(uri_string)
    @uri_string = uri_string
  end

  def call
    return unless uri

    class_key = host_name.split('.')[-2]
    CLASS_NAME_FOR[class_key]
  end

  def host_name
    return unless uri

    uri.host
  end

  def uri
    @uri ||= parse_uri
  end

  # https://stackoverflow.com/questions/5331014/check-if-given-string-is-an-url
  def parse_uri
    @uri = URI.parse(uri_string)
  rescue URI::BadURIError
    nil
  rescue URI::InvalidURIError
    nil
  end
end
