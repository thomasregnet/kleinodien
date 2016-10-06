class CreateRepositoryPositions < ActiveRecord::Migration[5.0]
  def change
    reversible do |create|
      create.up do
        execute <<-DDL.gsub /^\s+/, ''
          CREATE TABLE repository_positions(
            id                     serial NOT NULL,
            compilation_track_id   integer,
            compilation_release_id integer,
            piece_release_id       integer,
            created_at             timestamp without time zone NOT NULL,
            updated_at             timestamp without time zone NOT NULL,
            PRIMARY KEY (id),
            FOREIGN KEY (compilation_track_id, compilation_release_id)
              REFERENCES compilation_tracks(id, compilation_release_id),
            FOREIGN KEY (piece_release_id) references piece_releases(id)
          );
        DDL
      end
      create.down do
        execute 'DROP TABLE repository_positions;'
      end
    end
  end
end
