class AddImportOrderToReleaseImages < ActiveRecord::Migration[6.0]
  def change
    add_reference :release_images, :import_order, foreign_key: true
  end
end
