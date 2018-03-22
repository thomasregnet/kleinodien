module ImportStoreRequestsAndUrisKey
  extend ActiveSupport::Concern

  def requests_key
    "#{importer_name}:requests"
  end

  def uris_key
    "#{importer_name}:uris"
  end
end
