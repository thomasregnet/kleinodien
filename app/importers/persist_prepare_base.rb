# frozen_string_literal: true

# Base class for persist and prepare classes
class PersistPrepareBase
  def self.call(args)
    new(args).call
  end

  def initialize(proxy:)
    @proxy = proxy
  end

  attr_reader :proxy
end
