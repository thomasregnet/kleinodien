class CreateTableCtFormatDetails < ActiveRecord::Migration[5.0]
  def change
    execute <<-DDL
      CREATE TABLE ct_format_details (
        id                   serial PRIMARY KEY,
        compilation_track_id integer NOT NULL,
        abbr                 text    NOT NULL,
        position             integer NOT NULL,
        FOREIGN KEY (compilation_track_id) REFERENCES compilation_tracks (id),
        FOREIGN KEY (abbr) REFERENCES format_details (abbr)
      );

      CREATE UNIQUE INDEX ON ct_format_details (compilation_track_id, abbr);
      CREATE UNIQUE INDEX ON ct_format_details (compilation_track_id, position);
    DDL
  end
end
