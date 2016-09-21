class AddForeignKeyArtistsSources < ActiveRecord::Migration[5.0]
  def change
    add_foreign_key :artists,
                    :sources,
                    column: :source_name,
                    primary_key: :name
  end
end
