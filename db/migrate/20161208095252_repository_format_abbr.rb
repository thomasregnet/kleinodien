class RepositoryFormatAbbr < ActiveRecord::Migration[5.0]
  def change
    execute <<-DDL
      ALTER TABLE repositories DROP COLUMN format_name;

      ALTER TABLE repositories ADD COLUMN format_abbr text;

      ALTER TABLE repositories
      ADD CONSTRAINT fk_repositories_format_abbr
      FOREIGN KEY (format_abbr) REFERENCES formats (abbr);
    DDL
  end
end
