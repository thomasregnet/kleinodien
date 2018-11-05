# frozen_string_literal: true

# Import of MusicBrainz releases
class BrainzReleaseImporter
  def self.call(import_order)
    new(import_order).call
  end

  def initialize(import_order)
    @import_order = import_order
  end

  attr_reader :import_order

  def call
    # TODO: add real code here
    AlbumRelease.new
  end
end
