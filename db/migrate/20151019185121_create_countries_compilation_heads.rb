class CreateCountriesCompilationHeads < ActiveRecord::Migration[4.2]
  def change
    create_table :compilation_heads_countries, id: false do |t|
      t.references :country, index: true, foreign_key: true, null: false
      t.references :compilation_head, index: true, foreign_key: true, null: false
    end

    add_index(
      :compilation_heads_countries,
      [:country_id, :compilation_head_id],
      unique: true,
      name: :index_phc_on_country_id_and_compilation_head_id
    )
  end
end
