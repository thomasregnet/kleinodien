class CreateReleaseEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :release_events do |t|
      t.references :release, null: false, foreign_key: true
      t.references :area, null: false, foreign_key: true
      t.date :date
      t.column :date_mask, 'smallint'

      t.timestamps
    end
  end
end
