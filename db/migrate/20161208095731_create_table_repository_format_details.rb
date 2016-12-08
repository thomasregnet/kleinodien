class CreateTableRepositoryFormatDetails < ActiveRecord::Migration[5.0]
  def change
    execute <<-DDL
      CREATE TABLE repository_format_details (
        id            serial PRIMARY KEY,
        repository_id integer NOT NULL,
        abbr          text    NOT NULL,
        position      integer NOT NULL,
        FOREIGN KEY (repository_id) REFERENCES repositories (id),
        FOREIGN KEY (abbr) REFERENCES format_details (abbr)
      );

      CREATE UNIQUE INDEX ON repository_format_details
        (repository_id, abbr);

      CREATE UNIQUE INDEX ON repository_format_details
        (repository_id, position);
    DDL
  end
end
