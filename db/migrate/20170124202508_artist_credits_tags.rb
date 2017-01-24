class ArtistCreditsTags < ActiveRecord::Migration[5.0]
  def change
    create_table :artist_credits_tags, id: false do |t|
      t.references :artist_credit, foreign_key: true, null: false
      t.references :tag,           foreign_key: true, null: false
    end
  end
end
