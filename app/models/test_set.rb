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

  def retrieve(sub_set_no)
    subsets[sub_set_no] || raise(
      ArgumentError, "no such sub set: #{sub_set_no}"
    )
  end
end
