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
      fill_subset(subset)
      yield subset
    end

    def retrieve(subset_no)
      subsets[subset_no] || raise(
        ArgumentError, "no such sub set: #{subset_no}"
      )
    end

    private

    def fill_subset(subset)
      collected_references = references
      subsets.each do |predecessor|
        collected_references << predecessor.references
      end

      subset.add_references(collected_references.flatten)
    end
  end
end
