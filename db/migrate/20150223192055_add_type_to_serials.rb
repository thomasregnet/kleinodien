class AddTypeToSerials < ActiveRecord::Migration[4.2]
  def change
    add_column :serials, :type, :string, null: false
  end
end
