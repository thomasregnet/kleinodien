class BuildImportOrderFromUriService
  CLASS_NAME_FOR = {
    'discogs'     => 'DiscogsImportOrder',
    'musicbrainz' => 'BrainzImportOrder'
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

    class_name.constantize.new # TODO: prams
  end

  private

  def class_name
    CLASS_NAME_FOR[host_key]
  end

  def host_key
    return unless uri

    uri.host.split('.')[-2]
  end

  def uri
    @uri ||= parse_uri
  end

  def parse_uri
    URI.parse(uri_string)
  rescue URI::BadURIError
    nil
  rescue URI::InvalidURIError
    nil
  end
end
