class CreateSources < ActiveRecord::Migration
  def change
    reversible do |source|
      source.up do
        execute <<-DDL
          CREATE TABLE "sources" (
            "name"        varchar(255) PRIMARY KEY,
            "description" text,
            "created_at"  TIMESTAMP WITHOUT TIME ZONE NOT NULL,
            "updated_at"  TIMESTAMP WITHOUT TIME ZONE NOT NULL
          );
        DDL
      end
      source.down do
        drop_table :sources
      end
    end
  end
end
