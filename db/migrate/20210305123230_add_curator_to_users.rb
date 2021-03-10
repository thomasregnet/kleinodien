class AddCuratorToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :curator, :boolean, default: false, null: false
  end
end
