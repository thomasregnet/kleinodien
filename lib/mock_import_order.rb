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

  def done!
    @done = true
  end

  def done?
    @done
  end

  def failed?
    @failure
  end

  def failure!
    @failure = true
  end

  def persist!
    @persisting = true
  end

  def persisting?
    @persisting
  end

  def prepare!
    @preparing = true
  end

  def preparing?
    @preparing
  end
  # This method smells of :reek:UtilityFunction
  def transaction(&block)
    block.call
  end

  def type
    self.class.to_s
  end
end
