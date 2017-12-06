class TestSet
  def define
    yield TestSubset.new
  end
end
