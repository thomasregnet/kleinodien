module Import
  # Base class for import, prepare and persist
  class Base
    attr_reader :cache, :params

    def initialize(args = {})
      @cache  = args[:cache] || Import::Cache.new
      @params = args[:params]
    end

    def wanted
      return unless params
      params[:data][:attributes][:wanted]
    end
  end
end
