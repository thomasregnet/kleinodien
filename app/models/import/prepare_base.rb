module Import
  # Base class for prepare, extends Import::Base
  class PrepareBase < Base
    attr_reader :template

    def initialize(args)
      super(args)
      @template = args[:template]
    end
  end
end
