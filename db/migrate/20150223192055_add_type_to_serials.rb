class AddTypeToSerials < ActiveRecord::Migration
  def change
    add_column :serials, :type, :string, null: false
  end
end
