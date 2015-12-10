class CrReference < Reference
  has_one :compilation_release, foreign_key: 'reference_id'
end
