module ImportCacheConsumption
  extend ActiveSupport::Concern

  def import_cache
    @import_cache ||= ImportCache.new
  end
end
