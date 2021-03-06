class AddSourceToArtist < ActiveRecord::Migration[4.2]
  def change
    add_column :artists, :source_name, :string
    add_column :artists, :source_ident, :string
    add_foreign_key :artists,
                    :sources,
                    column: :source_name,
                    primary_key: :name
  end
end
