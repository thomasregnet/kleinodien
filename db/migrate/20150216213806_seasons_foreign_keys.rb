class SeasonsForeignKeys < ActiveRecord::Migration
  def change
    add_foreign_key :seasons, :serials, name: :seasons_fk_seasons
  end
end
