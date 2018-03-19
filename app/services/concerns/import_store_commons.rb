module ImportStoreCommons
  extend ActiveSupport::Concern

  def cache_key_for(key)
    "cache:#{key}"
  end

  def import_store
    @import_store ||= Redis.new(Rails.application.config_for(:import_store))
  end
end
