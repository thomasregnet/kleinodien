module Persist
  class BrainzCompilationRelease
    attr_reader :cache, :id

    def self.using_id(id, cache)
      new(id, cache).using_id
    end

    def initialize(id, cache)
      @id = id
      @cache = cache
    end

    def using_id

    end
  end
end
