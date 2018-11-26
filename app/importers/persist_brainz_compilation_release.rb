# frozen_string_literal: true

class PersistBrainzCompilationRelease
  def self.call(args)
    new(args).call
  end

  def initialize(args)
    @import_request = args[:import_request]
    @proxy          = args[:proxy]
  end

  attr_reader :import_request, :proxy

  def call
    persist_artist_credit
    persist_compilation_head
  end

  def persist_artist_credit
  end

  def persist_compilation_head
  end
end
