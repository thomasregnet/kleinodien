class CreateIso3166Part2Countries < ActiveRecord::Migration[6.0]
  def change
    create_table :iso3166_part2_countries do |t|
      t.string :code, null: false
      t.references :area, null: false, foreign_key: true

      t.timestamps
    end

    execute <<~DDL
      CREATE UNIQUE INDEX index_iso_3166_part2_countries_upper_code
      ON iso3166_part2_countries (UPPER(code));
    DDL
  end
end
