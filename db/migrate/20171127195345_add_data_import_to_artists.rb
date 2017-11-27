class AddDataImportToArtists < ActiveRecord::Migration[5.1]
  def change
    add_reference :artists, :data_import, foreign_key: true
  end
end
