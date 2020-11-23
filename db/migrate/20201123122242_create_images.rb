class CreateImages < ActiveRecord::Migration[6.0]
  def change
    create_table :images do |t|
      t.bigint :coverartarchive_code

      t.timestamps
    end
  end
end
