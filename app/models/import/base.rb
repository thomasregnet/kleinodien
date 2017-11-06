module Import
  # Base class for import, prepare and persist
  class Base
    attr_reader :cache, :foreign_id, :params

    def initialize(args = {})
      @cache  = args[:cache] || Import::Cache.new
      @params = args[:params]
      @foreign_id = init_foreign_id(args)
    end

    def wanted
      return unless params
      params[:data][:attributes][:wanted]
    end

    private

    def init_foreign_id(args)
      foreign_id = args[:foreign_id]
      return foreign_id if foreign_id

      foreign_id_class = args[:foreign_id_class]
      return unless foreign_id_class
      foreign_id_class.new(value: wanted)
    end

    # TODO: respond_to_missing?
    def method_missing(method, args = {})
      klass = "Import::#{method.to_s.camelize}".constantize
      merged_args = { cache: cache }.merge(args)
      klass.send(:new, merged_args)
      # TODO: call super
    end
  end
end
