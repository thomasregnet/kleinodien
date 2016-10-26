class CreateReFormats < ActiveRecord::Migration[5.0]
  def change
    reversible do |re_formats|
      re_formats.up do
        execute <<-DDL.gsub /^s+/, ''
          CREATE TABLE re_formats (
            name text PRIMARY KEY,
            FOREIGN KEY (name) REFERENCES formats (name)
          );
        DDL
      end
      re_formats.down do
        drop_table :re_formats
      end
    end
  end
end
