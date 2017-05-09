class CreateTrfAttributes < ActiveRecord::Migration[4.2]
  def change
    create_table :trf_attributes do |t|
      t.integer :track_id,              null: false
      t.integer :trf_attribute_kind_id, null: false
      t.integer :no,                    null: false

      t.timestamps null: false
    end
  end
end
