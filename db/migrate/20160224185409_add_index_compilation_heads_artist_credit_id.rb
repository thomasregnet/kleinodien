class AddIndexCompilationHeadsArtistCreditId < ActiveRecord::Migration[4.2]
  def change
    add_index :compilation_heads, :artist_credit_id
  end
end
