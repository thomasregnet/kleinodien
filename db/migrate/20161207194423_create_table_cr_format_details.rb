class CreateTableCrFormatDetails < ActiveRecord::Migration[5.0]
  def change
    execute <<-DDL
      CREATE TABLE cr_format_details (
        id           serial PRIMARY KEY,
        cr_format_id integer NOT NULL,
        abbr         text    NOT NULL,
        position     integer NOT NULL,
        FOREIGN KEY (cr_format_id) REFERENCES cr_formats (id),
        FOREIGN KEY (abbr) REFERENCES format_details (abbr)
      );

      CREATE UNIQUE INDEX ON cr_format_details (cr_format_id, abbr);
      CREATE UNIQUE INDEX ON cr_format_details (cr_format_id, position);
    DDL
  end
end
