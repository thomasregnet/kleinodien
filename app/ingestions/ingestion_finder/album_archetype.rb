module IngestionFinder
  class AlbumArchetype < NullFinder
    include Callable
    include Concerns::CodeFindable

    def initialize
      @factory = factory
    end

    attr_reader :factory

    def call(facade)
      find_by_cheap_codes(facade) || find_by_codes(facade)
    end

    def model_class = ::AlbumArchetype
  end
end
