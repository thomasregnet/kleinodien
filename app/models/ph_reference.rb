class PhReference < Reference
  has_one :piece_head, foreign_key: 'reference_id'
end
