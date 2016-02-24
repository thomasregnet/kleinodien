class AddIndexCompilationHeadsArtistCreditId < ActiveRecord::Migration
  def change
    add_index :compilation_heads, :artist_credit_id
  end
end
