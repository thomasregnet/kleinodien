# frozen_string_literal: true

# TODO: Delete this class?
# Import of MusicBrainz releases
class BrainzReleaseImporter
  def self.from_import_order(import_order)
    new(import_order: import_order).from_import_order
  end

  def initialize(args)
    @import_order = args[:import_order]
    @proxy        = args[:proxy] || BrainzProxy.new(import_order: import_order)
  end

  attr_reader :import_order

  def from_import_order
    raise ImportError::AlreadyExists, 'release exists' if find_persisted

    fetch_from_external_data_source
    AlbumRelease.new
  end

  def find_persisted
    CompilationRelease.find_by(brainz_code: import_order.code)
  end

  # TODO: use the fetcher when it is implemented
  def fetch_from_external_data_source
    # proxy.get(import_order)
  end
end
