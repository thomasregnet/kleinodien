class SurrogateKeyForSources < ActiveRecord::Migration[5.0]
  def change
    tables = [
      'artists',
      'artist_credits',
      'compilation_heads',
      'compilation_releases',
      'piece_heads',
      'piece_releases'
    ]

    execute <<-DDL
      ALTER TABLE sources DROP COLUMN name CASCADE;
      ALTER TABLE sources ADD COLUMN id SERIAL PRIMARY KEY;
      ALTER TABLE sources ADD COLUMN name TEXT NOT NULL;
    DDL

    tables.each do |table|
      execute "ALTER TABLE #{table} ADD COLUMN source_id INTEGER;"
      execute <<-DDL
        ALTER TABLE #{table} ADD CONSTRAINT fk_#{table}_source_id
          FOREIGN KEY (source_id) REFERENCES sources (id);
      DDL
    end
  end
end
