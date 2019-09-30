# frozen_string_literal: true

# Base class for persisting classes
class PersistBase < PersistPrepareBase
  def initialize(import_order:, **args)
    super(args)
    @import_order = import_order
  end

  attr_reader :import_order
end
