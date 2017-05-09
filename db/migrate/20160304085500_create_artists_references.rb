class CreateArtistsReferences < ActiveRecord::Migration[4.2]
  def change
    create_table :artists_references, id: false do |t|
      t.references :artist,    index: true, foreign_key: true
      t.references :reference, index: true, foreign_key: true
    end
  end
end
