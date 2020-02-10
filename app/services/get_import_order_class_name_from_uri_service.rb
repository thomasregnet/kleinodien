# frozen_string_literal: true

# Get the ImportOrder class name for a given uri
class GetImportOrderClassNameFromUriService < ServiceBase
  CLASS_NAME_FOR = {
    'discogs' => 'DiscogsImportOrder',
    'musicbrainz' => 'BrainzImportOrder'
  }.freeze

  # def self.call(uri_string)
  #   new(uri_string).call
  # end

  attr_reader :uri_string

  def initialize(args)
    @uri_string = args[:uri_string]
  end

  def call
    return unless host_name

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
  rescue URI::Error
    nil
  end
end
