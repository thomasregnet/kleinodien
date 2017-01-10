class RemoveSourceNames < ActiveRecord::Migration[5.0]
  def change
    tables = [
      'artists',
      'artist_credits',
      'compilation_heads',
      'compilation_releases',
      'piece_heads',
      'piece_releases'
    ]

    tables.each do |table|
      execute "ALTER TABLE #{table} DROP COLUMN source_name;"
    end
  end
end
