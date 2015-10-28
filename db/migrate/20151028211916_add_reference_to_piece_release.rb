class AddReferenceToPieceRelease < ActiveRecord::Migration
  def change
    add_reference :piece_releases, :reference, index: true, foreign_key: true
  end
end
