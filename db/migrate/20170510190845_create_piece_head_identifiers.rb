class CreatePieceHeadIdentifiers < ActiveRecord::Migration[5.1]
  def change
    execute <<-DDL
      CREATE TABLE piece_head_identifiers (
        id               bigserial PRIMARY KEY,
        value            text                        NOT NULL,
        piece_head_id    integer                     NOT NULL,
        source_id        integer                     NOT NULL,
        created_at       timestamp without time zone NOT NULL,
        updated_at       timestamp without time zone NOT NULL,

        FOREIGN KEY (piece_head_id) REFERENCES piece_heads (id),
        FOREIGN KEY (source_id) REFERENCES sources (id)
      );

      ALTER TABLE piece_heads DROP COLUMN source_ident;
      ALTER TABLE piece_heads DROP COLUMN source_id;
    DDL
  end
end
