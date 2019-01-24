class RenamePieceReleaseTagsToPieceTags < ActiveRecord::Migration[5.2]
  def change
    rename_table :piece_releases_tags, :pieces_tags
  end
end
