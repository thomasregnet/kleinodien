class TestSet < TestSubset
  def define
    yield TestSubset.new
  end
end
