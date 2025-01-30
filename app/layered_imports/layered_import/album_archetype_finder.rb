module LayeredImport
  class AlbumArchetypeFinder
    include Concerns::CodeFindable

    def initialize(order, facade:)
      @order = order
      @facade = facade
    end

    attr_reader :facade, :order

    def find
      find_by_cheap_codes || find_by_codes
    end
  end
end
