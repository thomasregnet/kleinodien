module ImportConnection
  class << self
    def redis
      @redis ||= Redis.new(Rails.application.config_for(:import_connection))
    end
  end
end
