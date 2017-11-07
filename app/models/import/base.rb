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

    def method_missing(method, args = {})
      class_name = import_service_class_name_for(method)
      if Import.const_defined?(class_name)
        klass = class_name.constantize
        merged_args = { cache: cache }.merge(args)
        return klass.send :perform, merged_args
      end
      super
    end

    def respond_to_missing?(method_name, _, &_block)
      class_name = import_service_class_name_for(method_name)
      Import.const_defined?(class_name)
    end

    def import_service_class_name_for(method)
      "Import::#{method.to_s.camelize}"
    end
  end
end
