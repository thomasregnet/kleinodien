# frozen_string_literal: true

# Import of MusicBrainz releases
class BrainzReleaseImporter
  def self.call(import_order)
    new(import_order).call
  end

  # TODO: initialize with args to make it possible to hand over the queue
  def initialize(import_order)
    @import_order = import_order
    @queue        = []
  end

  attr_reader :import_order

  def call
    # TODO: add real code here
    release = find_persisted
    return release if release

    request
    AlbumRelease.new
  end

  def find_persisted
    CompilationRelease.find_by(brainz_code: import_order.code)
  end

  def request

  end
end

