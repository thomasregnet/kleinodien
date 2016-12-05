class RenameNoColumnsToPosition < ActiveRecord::Migration[5.0]
  def change
    rename_column :compilation_tracks, :position, :location
    rename_column :compilation_tracks, :no, :position

    rename_column :compilation_track_details, :no, :position
    rename_column :cr_formats,                :no, :position
    rename_column :crf_details,               :no, :position
    rename_column :participants,              :no, :position
    rename_column :piece_heads,               :no, :position
    rename_column :repository_ref_details,    :no, :position
    rename_column :seasons,                   :no, :position
  end
end
