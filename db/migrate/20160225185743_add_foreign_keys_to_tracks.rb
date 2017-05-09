class AddForeignKeysToTracks < ActiveRecord::Migration[4.2]
  def change
    add_foreign_key :tracks, :piece_releases
    add_foreign_key :tracks, :compilation_releases
    add_foreign_key :tracks, :tr_format_kinds
  end
end
