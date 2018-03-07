module ImportConnection
  class << self
    def redis
      @redis ||= Redis.new(Rails.application.config_for(:import_connection))
    end

    def uri
      config = Rails.application.config_for(:import_connection)
      "#{config['url']}/#{config['db']}"
    end
  end
end
