class JoinImageTagsReleaseImages < ActiveRecord::Migration[6.0]
  def change
    create_join_table :image_tags, :release_images, column_options: { index: true }

    add_foreign_key :image_tags_release_images, :image_tags
    add_foreign_key :image_tags_release_images, :release_images
  end
end
