class AddBrainzCodeToCompilationReleases < ActiveRecord::Migration[5.1]
  def change
    add_column :compilation_releases, :brainz_code, :uuid

    add_index :compilation_releases,
              :brainz_code,
              unique: true,
              name: :index_on_compilation_releases_brainz_code
  end
end
