class AddArtistCreditRefToPieceRelease < ActiveRecord::Migration[5.1]
  def change
    add_reference :piece_releases, :artist_credit, foreign_key: true
  end
end
