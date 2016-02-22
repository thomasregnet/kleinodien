class AlbumRelease < CompilationRelease
  def self.with_discogs_id_exists?(discogs_id)
    with_id_from_data_supplier_exists?(discogs_id, 'Discogs')
  end
end
