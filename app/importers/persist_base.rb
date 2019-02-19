# frozen_string_literal: true

# Base class for persisting classes
class PersistBase < PersistPrepareBase
  def initialize(args)
    super(args)
    @import_order = args[:import_order]
  end

  attr_reader :import_order
end
