class RemoveSourceIdAndSourceIdentFromArtists < ActiveRecord::Migration[5.0]
  def change
    remove_column :artists, :source_ident
    remove_column :artists, :source_id
  end
end
