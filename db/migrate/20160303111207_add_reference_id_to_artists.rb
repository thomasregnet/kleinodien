class AddReferenceIdToArtists < ActiveRecord::Migration[4.2]
  def change
    add_reference :artists, :reference, index: true, foreign_key: true
  end
end
