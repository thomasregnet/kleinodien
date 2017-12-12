module TestData
  # TestData Set
  class TestSet < Subset
    attr_reader :subsets

    def initialize
      super
      @subsets = []
    end

    def define
      subset = Subset.new
      subsets << subset
      yield subset
    end

    def retrieve(subset_no)
      subsets[subset_no] || raise(
        ArgumentError, "no such sub set: #{subset_no}"
      )
    end
  end
end
