class AddDesignationToReleaseCopies < ActiveRecord::Migration[6.0]
  def change
    add_column :release_copies, :designation, :text, null: false

    add_index(:release_copies, %i[designation user_id], unique: true)
  end
end
