class TestSet < TestSubset
  attr_reader :subsets

  def initialize
    super
    @subsets = []
  end

  def define
    sub_set = TestSubset.new
    subsets << sub_set
    yield sub_set
  end
end
