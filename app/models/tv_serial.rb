class TvSerial < Serial
  has_many :seasons, class_name: 'TvSeason'
end
