class ChangeTypesOfSurces < ActiveRecord::Migration
  def change
    reversible do |source|
      source.up do
        execute <<~DDL
          DROP TABLE "sources" CASCADE;

          CREATE TABLE "sources" (
            "name"        character varying NOT NULL PRIMARY KEY,
            "description" character varying,
            "created_at"  TIMESTAMP WITHOUT TIME ZONE NOT NULL,
            "updated_at"  TIMESTAMP WITHOUT TIME ZONE NOT NULL
          );
        DDL
      end
      source.down do
        execute <<~DDL
          DROP TABLE "sources";

          CREATE TABLE "sources" (
            "name"        varchar(255) PRIMARY KEY,
            "description" text,
            "created_at"  TIMESTAMP WITHOUT TIME ZONE NOT NULL,
            "updated_at"  TIMESTAMP WITHOUT TIME ZONE NOT NULL
          );
        DDL
      end
    end
  end
end
