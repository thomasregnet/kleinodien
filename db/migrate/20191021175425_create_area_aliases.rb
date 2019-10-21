class CreateAreaAliases < ActiveRecord::Migration[6.0]
  def change
    create_table :area_aliases do |t|
      t.string :name, null: false
      t.string :sort_name, null: false
      t.date :begin_date
      t.column :begin_date_mask, 'smallint'
      t.date :end_date
      t.column :end_date_mask, 'smallint'
      t.boolean :gone
      t.string :locale
      t.string :type
      t.references :area, null: false, foreign_key: true

      t.timestamps
    end
  end
end
