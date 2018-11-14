module Importer
  # Base class for prepare, extends Importer::Base
  class PrepareBase < Base
    attr_reader :blueprint

    def initialize(args)
      super(args)
      @blueprint = args[:blueprint]
    end
  end
end
