class CreateSourceIdentifiers < ActiveRecord::Migration
  def change
    create_table :source_identifiers do |t|
      t.references :data_source, index: true, foreign_key: true, null: false
      t.string :identifier, null: false
      t.string :type, null: false

      t.timestamps null: false
    end

    add_index(
      :source_identifiers,
      [:data_source_id, :identifier, :type],
      unique: true,
      name: :index_src_id_on_data_src_ident_type
    )
  end
end
