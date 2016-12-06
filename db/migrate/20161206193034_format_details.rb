class FormatDetails < ActiveRecord::Migration[5.0]
  def change
    reversible do |format_detail|
      format_detail.up do
        execute <<-DDL
          CREATE TABLE format_details (
            abbr text PRIMARY KEY,
            name text NOT NULL
          );
        DDL
      end
      format_detail.down do
        execute 'DROP TABLE format_details;'
      end
    end
  end
end
