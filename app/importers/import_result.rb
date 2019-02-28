# frozen_string_literal: true

# Simple class for import results
class ImportResult < SimpleDelegator
  def initialize(args)
    @object  = args[:object]
    @created = args[:created] || false
    super(@object)
  end

  attr_reader :created, :object

  def created?
    created
  end

  def existed?
    !created
  end
end
