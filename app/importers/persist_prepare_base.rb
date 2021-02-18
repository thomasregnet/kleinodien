# frozen_string_literal: true

# Base class for persist and prepare classes
class PersistPrepareBase
  def self.call(args)
    new(**args).call
  end

  def initialize(import_order:, proxy:)
    @import_order = import_order
    @proxy        = proxy
  end

  attr_reader :import_order, :proxy
end
