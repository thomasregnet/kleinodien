class SeasonsForeignKeys < ActiveRecord::Migration[4.2]
  def change
    add_foreign_key :seasons, :serials, name: :seasons_fk_seasons
  end
end
