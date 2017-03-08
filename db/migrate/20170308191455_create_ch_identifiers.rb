class CreateChIdentifiers < ActiveRecord::Migration[5.0]
  def change
    execute <<-DDL
      CREATE TABLE ch_identifiers (
        id                     bigserial PRIMARY KEY,
        value                  text                        NOT NULL,
        compilation_head_id    integer                     NOT NULL,
        source_id              integer                     NOT NULL,
        created_at             timestamp without time zone NOT NULL,
        updated_at             timestamp without time zone NOT NULL,

        FOREIGN KEY (compilation_head_id) REFERENCES compilation_heads (id),
        FOREIGN KEY (source_id) REFERENCES sources (id)
      );

      ALTER TABLE compilation_heads DROP COLUMN source_ident;
      ALTER TABLE compilation_heads DROP COLUMN source_id;
    DDL
  end
end
