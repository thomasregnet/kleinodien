class AddImportOrderToArtists < ActiveRecord::Migration[5.2]
  def change
    add_reference :artists, :import_order, foreign_key: true
  end
end
