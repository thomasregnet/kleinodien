class AddIndicesToTracks < ActiveRecord::Migration
  def change
    add_index :tracks, :piece_release_id
    add_index :tracks, :compilation_release_id
    add_index :tracks, :tr_format_kind_id
  end
end
