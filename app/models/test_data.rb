#require 'brainz_release_ref'

class TestData
  attr_reader :name

  def self.define(name)
    yield new(name)
  end

  def initialize(name)
   @name = name 
  end

  def add(kind, code)
    require_kind(kind)
    ref_class = "#{kind.to_s.camelize}Ref".constantize
    ref_class.new(code: code)
  end

  def self.fetch(name)
    name
  end

  private

  def require_kind(kind)
    ref_to_require = "#{kind.to_s}_ref"
    begin
      require ref_to_require
    rescue LoadError
      raise ArgumentError, "invalid kind: #{kind}"
    end
  end
end
