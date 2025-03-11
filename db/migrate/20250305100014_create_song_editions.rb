class CreateSongEditions < ActiveRecord::Migration[8.0]
  def change
    create_table :song_editions, id: :uuid do |t|
      t.integer :discogs_code
      t.uuid :musicbrainz_code
      t.integer :wikidata_code

      t.timestamps
    end
  end
end
