class CreateXxFormats < ActiveRecord::Migration[5.0]
  def change
    tables = %w(ct_formats pt_formats repositoy_formats rp_formats)
    reversible do |f_tables|
      f_tables.up do
        tables.each do |table|
          execute <<-DDL.gsub /^\s+/, ''
            CREATE TABLE #{table} (
              name text PRIMARY KEY,
              FOREIGN KEY (name) REFERENCES formats (name)
            );
          DDL
        end
      end
      f_tables.down do
        tables.each { |table| execute "DROP TABLE #{table};" }
      end
    end
  end
end
