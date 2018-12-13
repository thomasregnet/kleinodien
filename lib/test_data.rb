# frozen_string_literal: true

require 'test_data/by_name'
# Get test-data from the filesystem
module TestData
  def self.by_name(name)
    ByName.call(name)
  end
end
