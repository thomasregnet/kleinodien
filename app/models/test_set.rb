class TestSet < TestSubset
  attr_reader :subsets

  def initialize
    super
    @subsets = []
  end

  def define
    subset = TestSubset.new
    subsets << subset
    yield subset
  end

  def retrieve(subset_no)
    subsets[subset_no] || raise(
      ArgumentError, "no such sub set: #{subset_no}"
    )
  end
end
