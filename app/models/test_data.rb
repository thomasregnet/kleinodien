#require 'brainz_release_ref'

class TestData
  attr_reader :name

  def self.define(name)
    yield TestSet.new
  end

  def self.retrieve(name)
    name
  end
end
