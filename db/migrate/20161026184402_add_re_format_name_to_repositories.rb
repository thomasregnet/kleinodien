class AddReFormatNameToRepositories < ActiveRecord::Migration[5.0]
  def change
    reversible do |re_format_name|
      re_format_name.up do
        execute <<-DDL.gsub /^\s+/, ''
          ALTER TABLE repositories
          ADD COLUMN re_format_name text;

          ALTER TABLE repositories
          ADD FOREIGN KEY (re_format_name)
          REFERENCES re_formats (name);

          CREATE INDEX index_repositories_re_format_name
          ON repositories (re_format_name);
        DDL
      end
      re_format_name.down do
        remove_column :repositories, :re_format_name
      end
    end
  end
end
