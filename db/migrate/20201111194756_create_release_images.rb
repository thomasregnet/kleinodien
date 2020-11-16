class CreateReleaseImages < ActiveRecord::Migration[6.0]
  def change
    create_table :release_images do |t|
      t.boolean :front, default: false, null: false
      t.boolean :back, default: false, null: false
      t.string :note
      t.references :release, null: false, foreign_key: true
      t.bigint :archive_org_code

      t.timestamps
    end
  end
end
