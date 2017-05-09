class CreateCompilationReleases < ActiveRecord::Migration[4.2]
  def change
    create_table :compilation_releases do |t|
      t.integer :compilation_head_id, null: false
      t.string :version
      t.string :type, null: false

      t.timestamps null: false
    end
  end
end
