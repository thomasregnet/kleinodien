class FkRepositoryPositionsPieceTracks < ActiveRecord::Migration[5.0]
  def change
    reversible do |fk|
      fk.up do
        execute <<-DDL.gsub /^\s+/, ''
          ALTER TABLE repository_positions
          ADD COLUMN piece_track_id integer;

          ALTER TABLE repository_positions
          ADD CONSTRAINT fk_repository_positions_piece_tracks
          FOREIGN KEY (piece_track_id)
          REFERENCES piece_tracks (id);
        DDL
      end
      fk.down do
        execute <<-DDL.gsub /^\s+/, ''
          ALTER TABLE repository_positions
          DROP CONSTRAINT fk_repository_positions_piece_tracks;

          ALTER TABLE repository_positions
          DROP COLUMN piece_track_id;
        DDL
      end
    end
  end
end
