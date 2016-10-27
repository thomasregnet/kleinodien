class RepositoryRefDetail < ApplicationRecord
  self.primary_key = [:ref_attribute_name, :repository_id, :no]

  belongs_to :attrib,
             class_name: RefDetail,
             primary_key: :name,
             foreign_key: :name
  belongs_to :repository
end
