class SeasonsSerialIdNoIdx < ActiveRecord::Migration[4.2]
  def change
    add_index(:seasons, [:no, :serial_id], unique: true)
  end
end
