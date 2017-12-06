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

  def self.retrieve(name)
    test_sets[name] || raise(ArgumentError, "no such test set: #{name}")
  end
end
