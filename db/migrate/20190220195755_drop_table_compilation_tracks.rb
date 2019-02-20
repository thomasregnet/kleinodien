class DropTableCompilationTracks < ActiveRecord::Migration[5.2]
  def change
    drop_table :compilation_track_details
    drop_table :ct_format_details
    drop_table :compilation_tracks
  end
end
