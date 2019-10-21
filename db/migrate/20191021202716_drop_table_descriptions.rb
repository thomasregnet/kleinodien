class DropTableDescriptions < ActiveRecord::Migration[6.0]
  def change
    drop_table :descriptions
  end
end
