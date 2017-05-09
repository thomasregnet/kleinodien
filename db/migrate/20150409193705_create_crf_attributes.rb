class CreateCrfAttributes < ActiveRecord::Migration[4.2]
  def change
    create_table :crf_attributes do |t|
      t.integer :cr_format_id
      t.integer :crf_attribute_kind_id
      t.integer :no

      t.timestamps null: false
    end
  end
end
