module Import
  # Base classs to persist data
  class PersistBase < PrepareBase
    # TODO: maybe PersistBase should inherit from Base and not from PrepareBase

    attr_reader :data_import

    def initialize(args = {})
      @data_import = args[:data_import]
      super(args)
    end
  end
end
