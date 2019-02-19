class AddImportOrderToArtistCredits < ActiveRecord::Migration[5.2]
  def change
    add_reference :artist_credits, :import_order, foreign_key: true
  end
end
