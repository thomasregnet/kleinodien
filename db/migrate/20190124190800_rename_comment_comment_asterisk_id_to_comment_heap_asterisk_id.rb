class RenameCommentCommentAsteriskIdToCommentHeapAsteriskId < ActiveRecord::Migration[5.2]
  def change
    rename_column :comments, :compilation_head_id, :heap_head_id
    rename_column :comments, :compilation_release_id, :heap_id
  end
end
