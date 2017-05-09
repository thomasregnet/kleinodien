class CreateCompilationMedia < ActiveRecord::Migration[4.2]
  def change
    create_table :compilation_media do |t|
      t.integer :compilation_release_id, null: false
      t.integer :no, null: false
      t.string :title

      t.timestamps null: false
    end
  end
end
