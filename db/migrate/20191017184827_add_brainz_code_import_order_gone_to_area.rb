class AddBrainzCodeImportOrderGoneToArea < ActiveRecord::Migration[6.0]
  def change
    add_column :areas, :brainz_code, :uuid
    add_column :areas, :gone, :boolean
    add_reference :areas, :import_order, foreign_key: true
  end
end
