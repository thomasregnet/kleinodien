module IngestionReflections
  class AlbumArchetype
    include Concerns::Reflectable

    def initialize(factory)
      @factory = factory
    end

    attr_reader :factory

    def record_class = ::AlbumArchetype

    delegate_missing_to :record_class

    def create_finder = IngestionFinder::AlbumArchetype.new

    def delegated_base_reflections = factory.create(:archetype)
  end
end
