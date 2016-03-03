class AddReferenceIdToArtists < ActiveRecord::Migration
  def change
    add_reference :artists, :reference, index: true, foreign_key: true
  end
end
