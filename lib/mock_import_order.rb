# frozen_string_literal: true

# Mock an ImportOrder
# implements #code and #failure!
# :reek:MissingSafeMethod { exclude: [ failure! ] }
class MockImportOrder
  def initialize(code: nil)
    @code    = code
    @failure = false
  end

  attr_reader :code

  def failed?
    @failure
  end

  def failure!
    @failure = true
  end

  def persisting?
    false
  end

  def type
    self.class.to_s
  end
end
