class DropTableCrLabels < ActiveRecord::Migration[5.2]
  def change
    drop_table :cr_labels
  end
end
