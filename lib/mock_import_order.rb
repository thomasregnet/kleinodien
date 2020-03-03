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

  def failure!
    @failure = true
  end

  def failure?
    failure
  end

  # rubocop:disable Naming/PredicateName
  def has_received_failure
    failure
  end
  # rubocop:enable Naming/PredicateName
end
