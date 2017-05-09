class AddForeignKeyCompilationHeadsArtistCreditId < ActiveRecord::Migration[4.2]
  def change
    add_foreign_key :compilation_heads, :artist_credits
  end
end
