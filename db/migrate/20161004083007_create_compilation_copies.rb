class CreateCompilationCopies < ActiveRecord::Migration[5.0]
  def change
    create_table :compilation_copies do |t|
      t.references :compilation_release, foreign_key: true, null: false
      t.references :user,                foreign_key: true, null: false
      t.text :explanation

      t.timestamps
    end
  end
end
