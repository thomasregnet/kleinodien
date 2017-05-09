class CreateCrFormatClarifications < ActiveRecord::Migration[4.2]
  def change
    create_table :cr_format_clarifications do |t|
      t.integer :cr_format_id,   null: false
      t.integer :format_kind_id, null: false
      t.integer :no,             null: false

      t.timestamps null: false
    end
  end
end
