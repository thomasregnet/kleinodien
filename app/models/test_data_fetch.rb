# fetch test data from the filesystem
class TestDataFetch
  TEST_DATA_ROOT = %w[fixtures].freeze

  attr_reader :reference

  def self.perform(reference)
    new(reference).perform
  end

  def initialize(reference)
    @reference = reference
  end

  def perform
    # TODO: remove '.xml' from test data files
    path = [TEST_DATA_ROOT, reference.to_key + '.xml']
    file_name = File.join(path.flatten)
    File.open(file_name).read
  end
end
