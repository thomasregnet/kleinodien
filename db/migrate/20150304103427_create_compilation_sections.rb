class CreateCompilationSections < ActiveRecord::Migration[4.2]
  def change
    create_table :compilation_sections do |t|
      t.integer :compilation_medium_id, null: false
      t.integer :section_format_id,     null: false
      t.integer :no,                    null: false
      t.string :side

      t.timestamps null: false
    end
  end
end
