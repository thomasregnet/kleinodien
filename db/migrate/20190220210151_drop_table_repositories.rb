class DropTableRepositories < ActiveRecord::Migration[5.2]
  def change
    remove_column :comments, :repository_id

    drop_table :repository_positions
    drop_table :repository_format_details
    drop_table :repositories
  end
end
