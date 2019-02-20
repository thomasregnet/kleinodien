class DropTableCompilationReleases < ActiveRecord::Migration[5.2]
  def change
    remove_column :repository_positions, :compilation_release_id
    remove_column :brainz_releases, :compilation_release_id
    remove_column :comments, :heap_id
    remove_column :compilation_copies, :compilation_release_id
    remove_column :compilation_releases_countries, :compilation_release_id
    remove_column :compilation_releases_tags, :compilation_release_id
    remove_column :compilation_tracks, :compilation_release_id
    remove_column :cr_companies, :compilation_release_id
    remove_column :cr_credits, :compilation_release_id
    remove_column :cr_formats, :compilation_release_id
    remove_column :cr_labels, :compilation_release_id
    remove_column :descriptions, :compilation_release_id
    remove_column :original_exemplars, :compilation_release_id
    remove_column :product_numbers, :compilation_release_id
    remove_column :ratings, :compilation_release_id
    drop_table :compilation_releases
  end
end
