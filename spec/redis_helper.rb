module RedisHelper
  def self.import_store
    @import_store ||= Redis.new(Rails.application.config_for(:import_store))
  end
end
