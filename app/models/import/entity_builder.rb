module Import
  class EntityBuilder
    include Callable
    include Import::Concerns::EntityBuildable

    def initialize(adapter_layer, kind, options)
      @adapter_layer = adapter_layer
      @kind = kind
      @options = options
    end

    def call
      assign_has_many_entities
      assign_foreign_attributes
      assign_foreign_bases
      assign_delegated_base
      assign_links

      entity
    end

    private

    attr_reader :adapter_layer, :kind, :options
    delegate_missing_to :adapter_layer

    def assign_delegated_base
      delegated_base_class = reflections.delegated_base_class
      return unless delegated_base_class

      delegated_base = build_delegated_base(facade, delegated_base_class.name)
      writer_name = reflections.delegated_of_association_writer

      entity.send(writer_name, delegated_base)
    end

    def facade
      @facade ||= facade_layer.build_facade(reflections, options)
    end

    def entity
      @entity ||= reflections.base_class.new(inherent_attributes)
    end

    def reflections
      @reflections ||= build_reflections_for(kind)
    end
  end
end
