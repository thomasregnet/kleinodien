class SeasonsSerialIdNoIdx < ActiveRecord::Migration
  def change
    add_index(:seasons, [:no, :serial_id], unique: true)
  end
end
