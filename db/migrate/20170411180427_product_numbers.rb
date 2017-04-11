class ProductNumbers < ActiveRecord::Migration[5.0]
  def change
    execute <<-DDL
      DROP TABLE compilation_identifiers CASCADE;
      DROP TABLE identifier_types CASCADE;

      CREATE TABLE product_number_types (
        id         bigserial             PRIMARY KEY,
        name       citext                UNIQUE NOT NULL,
        note       text,

        created_at timestamp without time zone NOT NULL,
        updated_at timestamp without time zone NOT NULL
      );

      CREATE TABLE product_numbers (
        id                     bigserial PRIMARY KEY,
        code                   text      NOT NULL,
        disambiguation         text,
        compilation_release_id integer   NOT NULL,
        product_number_type_id bigint    NOT NULL,

        created_at timestamp without time zone NOT NULL,
        updated_at timestamp without time zone NOT NULL,

        FOREIGN KEY (compilation_release_id)
          REFERENCES compilation_releases(id),

        FOREIGN KEY (product_number_type_id)
          REFERENCES product_number_types(id)
      );

      CREATE UNIQUE INDEX ON product_numbers
        (code, compilation_release_id, product_number_type_id)
        WHERE disambiguation IS NULL;

      CREATE UNIQUE INDEX ON product_numbers
        (code, disambiguation, compilation_release_id, product_number_type_id)
        WHERE disambiguation IS NOT NULL;
    DDL
  end
end
