class TvSeason < Season
  belongs_to(:tv_serial,
             class_name: 'TvSerial',
             inverse_of: :seasons,
             foreign_key: :serial_id)
end
