class AddArtistCreditRefToCompilationRelease < ActiveRecord::Migration[5.1]
  def change
    add_reference :compilation_releases, :artist_credit, foreign_key: true
  end
end
