class AddDataSupplierRefToArtistCredits < ActiveRecord::Migration
  def change
    add_reference :artist_credits, :data_supplier, index: true, foreign_key: true
  end
end
