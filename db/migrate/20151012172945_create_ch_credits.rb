class CreateChCredits < ActiveRecord::Migration
  def change
    create_table :ch_credits do |t|
      t.references :artist_credit, index: true, foreign_key: true, null: false
      t.references :compilation_release, index: true, foreign_key: true, null: false
      t.references :job, index: true, foreign_key: true
      t.string :role

      t.timestamps null: false
    end
  end
end
