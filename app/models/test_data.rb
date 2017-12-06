#require 'brainz_release_ref'

class TestData
  attr_reader :name

  def self.define(name)
    yield TestSet.new
  end

  def self.fetch(name)
    name
  end
end
