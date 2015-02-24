class TvSerial < Serial
  # has_many(:seasons,
  #          class_name: 'TvSeason',
  #          inverse_of: :serial,
  #          foreign_key: :serial_id)
end
