class AddImporterToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :importer, :boolean, default: false
  end
end
