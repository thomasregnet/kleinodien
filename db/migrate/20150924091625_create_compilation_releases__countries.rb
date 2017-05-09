class CreateCompilationReleasesCountries < ActiveRecord::Migration[4.2]
  def change
    create_table :compilation_releases_countries do |t|
      t.integer :no, null: false
      t.integer :compilation_release_id, null: false
      t.integer :country_id, null: false

      t.timestamps null: false
    end

    # the name of the auto-generated index is to long, so we have
    # to specify another one
    add_index(
      :compilation_releases_countries,
      [:compilation_release_id, :country_id],
      name: 'index_compilation_releases_countries_no_and_ids',
      unique: true
    )
  end
end
