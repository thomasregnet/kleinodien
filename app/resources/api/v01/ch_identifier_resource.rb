class Api::V01::ChIdentifierResource < JSONAPI::Resource
  attributes :compilation_head_id, :source_id, :value

  filters :compilation_head_id, :source_id, :value

  has_one :compilation_head
  has_one :source
end
