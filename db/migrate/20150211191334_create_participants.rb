class CreateParticipants < ActiveRecord::Migration
  def change
    create_table :participants do |t|
      t.integer, :no
      t.string :joinparse
      t.integer :artist_id
      t.integer :artist_credit_id

      t.timestamps null: false
    end
  end
end
