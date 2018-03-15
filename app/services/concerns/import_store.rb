# Provides the method import_store which returns a redis connection
module ImportStore
  extend ActiveSupport::Concern

  module ClassMethods
    def import_store
      @redis ||= Redis.new(Rails.application.config_for(:import_store))
    end
  end

  def import_store
    @redis ||= Redis.new(Rails.application.config_for(:import_store))
  end
end
