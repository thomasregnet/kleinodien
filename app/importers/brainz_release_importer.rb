# frozen_string_literal: true

# Import of MusicBrainz releases
class BrainzReleaseImporter
  def self.from_import_order(import_order)
    new(import_order: import_order).from_import_order
  end

  # TODO: use the fetcher when it is implemented
  def initialize(args)
    @import_order = args[:import_order]
    @fetcher      = args[:fetcher] # || BrainzDataFetcher.new
  end

  attr_reader :import_order

  def from_import_order
    release = find_persisted
    return release if release

    fetch_from_external_data_source
    AlbumRelease.new
  end

  def find_persisted
    CompilationRelease.find_by(brainz_code: import_order.code)
  end

  # TODO: use the fetcher when it is implemented
  def fetch_from_external_data_source
    # fetcher.get(import_order)
  end
end

