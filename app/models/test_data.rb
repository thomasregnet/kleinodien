# Define and retrieve test data for developing Kleinodien
class TestData
  @test_sets = {}

  class << self
    attr_reader :test_sets
  end

  def self.define(name)
    test_set = TestSet.new
    test_sets[name] = test_set
    yield test_set
  end

  def self.retrieve(name, subset_no = nil)
    test_set = test_sets[name]
    raise ArgumentError, "no such test set: #{name}" unless test_set
    return test_set unless subset_no
    test_set.retrieve(subset_no)
  end
end
