class TvSeason < Season
  belongs_to :tv_serial, inverse_of: :season, foreign_key: :sereial_id
end
