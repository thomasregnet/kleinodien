class RenameReleaseImagesFrontAndBack < ActiveRecord::Migration[6.0]
  def change
    rename_column :release_images, :front, :front_cover
    rename_column :release_images, :back, :back_cover
  end
end
