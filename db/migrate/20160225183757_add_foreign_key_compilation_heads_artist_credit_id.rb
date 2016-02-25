class AddForeignKeyCompilationHeadsArtistCreditId < ActiveRecord::Migration
  def change
    add_foreign_key :compilation_heads, :artist_credits
  end
end
