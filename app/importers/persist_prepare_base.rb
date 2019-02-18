# frozen_string_literal: true

# Base class for persist and prepare classes
class PersistPrepareBase
  def self.call(args)
    new(args).call
  end

  def initialize(args)
    @proxy = args[:proxy]
  end

  attr_reader :proxy

  def call
    raise NotImplementedError, "#{self.class} does missed to implement #call"
  end
end
