class ChReference < Reference
  has_one :compilation_head, foreign_key: 'reference_id'
end
