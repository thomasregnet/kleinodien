module Import
  # Base class for import, prepare and persist
  class Base
    attr_reader :cache, :knowledge, :reference, :params

    def initialize(args = {})
      @cache     = args[:cache] || Import::Cache.new
      @knowledge = args[:knowledge] || Import::Knowledge.new
      @params    = args[:params]
      @reference = init_reference(args)
    end

    def wanted
      return unless params
      params[:data][:attributes][:wanted]
    end

    alias ask knowledge

    private

    def init_reference(args)
      reference = args[:reference]
      return reference if reference

      reference_class = args[:reference_class]
      return unless reference_class
      reference_class.new(code: wanted)
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
