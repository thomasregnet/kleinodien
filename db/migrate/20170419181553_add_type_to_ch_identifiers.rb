class AddTypeToChIdentifiers < ActiveRecord::Migration[5.0]
  def change
    add_column :ch_identifiers, :type, :text, null: false
  end
end
