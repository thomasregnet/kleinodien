module Import::Concerns
  module EntityBuildable
    extend ActiveSupport::Concern

    def assign_has_many_entities
      reflections.has_many_associations.map do |association|
        build_has_many_associations(association, entity, facade)
      end
    end

    def assign_foreign_attributes
      reflections.belong_to_associations.each do |association|
        adapter_layer.assign_foreign_attribute(association, entity, facade)
      end
    end

    def assign_foreign_bases
      reflections.foreign_base_associations.each do |association|
        adapter_layer.assign_foreign_base(association, entity, facade)
      end
    end

    def assign_links
      adapter_layer.assign_links(entity, facade, reflections)
    end

    def inherent_attributes
      names = reflections.inherent_attribute_names
      facade.scrape_many(names)
    end
  end
end
