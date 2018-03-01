module Fetcher
  class Base
    attr_reader :conventions

    def initialize(args = {})
      @conventions = Conventions.new(args)
    end
  end
end
