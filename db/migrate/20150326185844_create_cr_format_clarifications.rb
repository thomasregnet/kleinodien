class CreateCrFormatClarifications < ActiveRecord::Migration
  def change
    create_table :cr_format_clarifications do |t|
      t.integer :cr_format_id
      t.integer :format_kind_id
      t.integer :no

      t.timestamps null: false
    end
  end
end
