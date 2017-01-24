class TagHasAndBelongsToManyAssociations < ActiveRecord::Migration[5.0]
  def change
    create_table :artists_tags, id: false do |t|
      t.references :artist, foreign_key: true, null: false
      t.references :tag,    foreign_key: true, null: false
    end

    create_table :compilation_heads_tags, id: false do |t|
      t.references :compilation_head, foreign_key: true, null: false
      t.references :tag,              foreign_key: true, null: false
    end

    create_table :compilation_releases_tags, id: false do |t|
      t.references :compilation_release, foreign_key: true, null: false
      t.references :tag,                 foreign_key: true, null: false
    end

    create_table :piece_heads_tags, id: false do |t|
      t.references :piece_head, foreign_key: true, null: false
      t.references :tag,        foreign_key: true, null: false
    end

    create_table :piece_releases_tags, id: false do |t|
      t.references :piece_release, foreign_key: true, null: false
      t.references :tag,           foreign_key: true, null: false
    end

    create_table :seasons_tags, id: false do |t|
      t.references :season, foreign_key: true, null: false
      t.references :tag,    foreign_key: true, null: false
    end

    create_table :serials_tags, id: false do |t|
      t.references :serial, foreign_key: true, null: false
      t.references :tag,    foreign_key: true, null: false
    end

    create_table :stations_tags, id: false do |t|
      t.references :station, foreign_key: true, null: false
      t.references :tag,     foreign_key: true, null: false
    end
  end
end
