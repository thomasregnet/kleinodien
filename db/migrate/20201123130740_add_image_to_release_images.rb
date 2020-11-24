class AddImageToReleaseImages < ActiveRecord::Migration[6.0]
  def change
    remove_column :release_images, :archive_org_code, :bigint
    add_reference :release_images, :image, null: false, foreign_key: true
  end
end
