class CreateParticipants < ActiveRecord::Migration
  def change
    create_table :participants do |t|
      t.integer :no,               null: false
      t.string  :joinparse
      t.integer :artist_id,        null: false
      t.integer :artist_credit_id, null: false

      t.timestamps null: false
    end
  end
end
