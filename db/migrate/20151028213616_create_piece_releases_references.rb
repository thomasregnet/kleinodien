class CreatePieceReleasesReferences < ActiveRecord::Migration[4.2]
  def change
    create_table :piece_releases_references, id: false do |t|
      t.references :piece_release, index: true, foreign_key: true
      t.references :reference, index: true, foreign_key: true
    end
  end
end
