# frozen_string_literal: true

# Release of a music album
class AlbumRelease < Heap
  belongs_to :artist_credit, required: false

  def self.with_discogs_id_exists?(discogs_id)
    with_id_from_data_supplier_exists?(discogs_id, 'Discogs')
  end
end
