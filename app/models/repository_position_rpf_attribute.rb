class RepositoryPositionRpfAttribute < ApplicationRecord
  self.primary_key = [:ref_attribute_name, :repository_id, :no]

  belongs_to :attrib,
             class_name: RefAttribute,
             primary_key: :name,
             foreign_key: :ref_attribute_name
  belongs_to :repository
end
