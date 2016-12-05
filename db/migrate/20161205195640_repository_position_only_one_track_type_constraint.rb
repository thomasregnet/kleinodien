class RepositoryPositionOnlyOneTrackTypeConstraint < ActiveRecord::Migration[5.0]
  def change
    execute <<-DDL
      ALTER TABLE repository_positions
        ADD CONSTRAINT only_one_track_type check (
            (compilation_track_id IS NOT NULL)::integer +
            (piece_track_id       IS NOT NULL)::integer <= 1
      );
    DDL
  end
end
