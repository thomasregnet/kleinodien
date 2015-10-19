class CreateCountriesPieceReleases < ActiveRecord::Migration
  def change
    create_table :countries_piece_releases, id: false do |t|
      t.references :country, index: true, foreign_key: true, null: false
      t.references :piece_release, index: true, foreign_key: true, null: false
    end

    add_index(
      :countries_piece_releases,
      [:country_id, :piece_release_id],
      unique: true,
      name: :index_cpr_on_country_id_and_piece_release_id
    )
  end
end
