class NewCrFromats < ActiveRecord::Migration[5.0]
  def change
    execute <<-DDL
      DROP TABLE cr_formats CASCADE;

      CREATE TABLE cr_formats (
        id                     serial PRIMARY KEY,
        compilation_release_id integer NOT NULL,
        abbr                   text    NOT NULL,
        position               integer NOT NULL,
        quantity               integer NOT NULL,
        note                   text,
        FOREIGN KEY (abbr) REFERENCES formats (abbr),
        FOREIGN KEY (compilation_release_id)
          REFERENCES compilation_releases (id)
      );

      CREATE UNIQUE INDEX ON cr_formats
        (compilation_release_id, position);
    DDL
  end
end
