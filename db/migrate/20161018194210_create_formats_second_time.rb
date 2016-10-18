class CreateFormatsSecondTime < ActiveRecord::Migration[5.0]
  def change
    reversible do |formats|
      formats.up do
        execute <<-DDL.gsub /^\s+/, ''
          CREATE TABLE formats (
            name         text PRIMARY KEY,
            abbr         text NOT NULL,
            created_at   timestamp without time zone NOT NULL,
            updated_at   timestamp without time zone NOT NULL
          );
        DDL
      end
      formats.down do
        drop_table :formats
      end
    end
  end
end
