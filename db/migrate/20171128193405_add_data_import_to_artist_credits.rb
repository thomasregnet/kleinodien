class AddDataImportToArtistCredits < ActiveRecord::Migration[5.1]
  def change
    add_reference :artist_credits, :data_import, foreign_key: true
  end
end
