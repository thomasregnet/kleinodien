# frozen_string_literal: true

# Simple class for import results
class ImportResult < SimpleDelegator
  def initialize(args)
    @result  = args[:result]
    @created = args[:created] || false
    super(@result)
  end

  attr_reader :created, :result

  def created?
    created
  end

  def existed?
    !created
  end
end
