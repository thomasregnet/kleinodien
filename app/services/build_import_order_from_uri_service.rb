# frozen_string_literal: true

# Takes an uri as parameter and returns an initialized ImportOrder object
class BuildImportOrderFromUriService < ServiceBase
  CLASS_NAME_FOR = {
    'discogs' => 'DiscogsImportOrder',
    'musicbrainz' => 'BrainzImportOrder'
  }.freeze

  PARAMS_CLASS_FOR = {
    'musicbrainz' => 'BrainzImportOrderParamsFromUriService'
  }.freeze

  def initialize(args)
    @uri_string = args[:uri_string]
    @user       = args[:user]
  end

  attr_reader :uri_string, :user

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

    # PARAMS_CLASS_FOR[host_key] sets "code" and "kind"
    params = PARAMS_CLASS_FOR[host_key].constantize.call(uri: uri)
    params[:user] = user
    params
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
