class UniqueIndexOnCompilationTracksIdAndPieceReleaseId < ActiveRecord::Migration[5.0]
  def change
    add_index :compilation_tracks,
              [:id, :compilation_release_id],
              name: :compilation_tracks_id_and_compilation_release_id,
              unique: true
  end
end
