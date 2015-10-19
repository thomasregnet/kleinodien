class CreateCountriesCompilationHeads < ActiveRecord::Migration
  def change
    create_table :countries_compilation_heads, id: false do |t|
      t.references :country, index: true, foreign_key: true, null: false
      t.references :compilation_head, index: true, foreign_key: true, null: false
    end

    add_index(
      :countries_compilation_heads,
      [:country_id, :compilation_head_id],
      unique: true,
      name: :index_cph_on_country_id_and_compilation_head_id
    )
  end
end
