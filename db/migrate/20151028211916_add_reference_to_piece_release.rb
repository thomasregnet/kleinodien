class AddReferenceToPieceRelease < ActiveRecord::Migration[4.2]
  def change
    add_reference :piece_releases, :reference, index: true, foreign_key: true
  end
end
